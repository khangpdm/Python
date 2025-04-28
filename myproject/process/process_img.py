import os
import django
import imutils
import numpy as np
import cv2
from math import ceil
from model_test import SimpleCNN
from collections import defaultdict
import torch

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.myproject.settings')
django.setup()

from myapp.models import NganHangCauHoi, ChiTietBaiLam, KetQua, BaiLam, DeThiChiTiet

def get_x(s):
    return s[1][0]

def get_y(s):
    return s[1][1]

def get_h(s):
    return s[1][3]

def get_x_ver1(s):
    s = cv2.boundingRect(s)
    return s[0] * s[1]

def crop_image(img):
    gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray_img, (5, 5), 0)
    img_canny = cv2.Canny(blurred, 100, 200)
    cnts = cv2.findContours(img_canny.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)

    ans_blocks = []
    x_old, y_old, w_old, h_old = 0, 0, 0, 0

    if len(cnts) > 0:
        cnts = sorted(cnts, key=get_x_ver1)

        for i, c in enumerate(cnts):
            x_curr, y_curr, w_curr, h_curr = cv2.boundingRect(c)

            if w_curr * h_curr > 100000:
                check_xy_min = x_curr * y_curr - x_old * y_old
                check_xy_max = (x_curr + w_curr) * (y_curr + h_curr) - (x_old + w_old) * (y_old + h_old)

                if len(ans_blocks) == 0 or (check_xy_min > 20000 and check_xy_max > 20000):
                    ans_blocks.append(
                        (gray_img[y_curr:y_curr + h_curr, x_curr:x_curr + w_curr], [x_curr, y_curr, w_curr, h_curr]))
                    x_old, y_old, w_old, h_old = x_curr, y_curr, w_curr, h_curr

        sorted_ans_blocks = sorted(ans_blocks, key=get_x)
        return sorted_ans_blocks

def process_ans_blocks(ans_blocks):
    list_answers = []

    for ans_block in ans_blocks:
        ans_block_img = np.array(ans_block[0])
        offset1 = ceil(ans_block_img.shape[0] / 6)

        for i in range(6):
            box_img = ans_block_img[i * offset1:(i + 1) * offset1, :]
            height_box = box_img.shape[0]
            box_img = box_img[14:height_box - 14, :]
            offset2 = ceil(box_img.shape[0] / 5)

            for j in range(5):
                list_answers.append(box_img[j * offset2:(j + 1) * offset2, :])

    return list_answers

def process_list_ans(list_answers):
    list_choices = []
    offset = 44
    start = 32

    for answer_img in list_answers:
        for i in range(4):
            bubble_choice = answer_img[:, start + i * offset:start + (i + 1) * offset]
            bubble_choice = cv2.threshold(bubble_choice, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
            bubble_choice = cv2.resize(bubble_choice, (28, 28), cv2.INTER_AREA)
            bubble_choice = bubble_choice.reshape((28, 28, 1))
            list_choices.append(bubble_choice)

    if len(list_choices) != 480:
        raise ValueError("Length of list_choices must be 480")
    
    return list_choices

def map_answer(idx):
    if idx % 4 == 0:
        return "A"
    elif idx % 4 == 1:
        return "B"
    elif idx % 4 == 2:
        return "C"
    else:
        return "D"

def get_answers(list_answers):
    results = defaultdict(list)
    model = SimpleCNN('model_weight.pth')
    
    # Load model weights with weights_only=True for safety
    model.load_state_dict(torch.load('D:/Python/Python-main/myproject/process/model_weight.pth', weights_only=True)) #Sửa lại đường dẫn
    model.eval()  # Set model to evaluation mode

    list_answers = np.array(list_answers)

    with torch.no_grad():  # Disable gradient computation
        # Chuyển đổi và chuẩn hóa dữ liệu đầu vào
        scores = model(torch.tensor(list_answers, dtype=torch.float32).permute(0, 3, 1, 2) / 255.0)

    for idx, score in enumerate(scores):
        question = idx // 4

        # Kiểm tra xem xác suất cho lựa chọn đã chọn có lớn hơn 0.9 không
        if score[1] > 0.9:
            chosed_answer = map_answer(idx)
            results[question + 1].append(chosed_answer)  # Thêm câu trả lời vào kết quả

    return results

def get_correct_answer(question_id):
    try:
        question = NganHangCauHoi.objects.get(id=question_id)
        return question.dap_an_dung
    except NganHangCauHoi.DoesNotExist:
        return None

def save_answers_to_db(answers, id_bai_lam):
    bai_lam = BaiLam.objects.get(id=id_bai_lam)
    # Delete existing ChiTietBaiLam entries for this bai_lam to avoid duplicates
    ChiTietBaiLam.objects.filter(id_bai_lam=bai_lam).delete()

    # Get all question IDs for the exam
    question_ids = DeThiChiTiet.objects.filter(de_thi=bai_lam.id_de).values_list('cau_hoi_id', flat=True)

    for question_id in question_ids:
        if question_id in answers:
            answer_list = answers[question_id]
            if len(answer_list) > 1:
                combined_answer = ', '.join(answer_list)
                ket_qua = 'Sai'
            else:
                answer = answer_list[0]
                correct_answer = get_correct_answer(question_id)
                ket_qua = 'Đúng' if answer == correct_answer else 'Sai'
                combined_answer = answer
        else:
            combined_answer = ''
            ket_qua = 'Chưa trả lời'

        ChiTietBaiLam.objects.create(
            id_bai_lam=bai_lam,
            id_cau_hoi_id=question_id,
            cau_tra_loi=combined_answer,
            ket_qua=ket_qua
        )

def calculate_total_score(answers, id_bai_lam):
    bai_lam = BaiLam.objects.get(id=id_bai_lam)
    question_ids = DeThiChiTiet.objects.filter(de_thi=bai_lam.id_de).values_list('cau_hoi_id', flat=True)
    total_questions = len(question_ids)  # Use dynamic total questions count
    total_correct = 0
    total_answered = 0
    for question_id in question_ids:
        if question_id in answers and len(answers[question_id]) == 1:
            total_answered += 1
            answer = answers[question_id][0]
            correct_answer = get_correct_answer(question_id)
            if answer == correct_answer:
                total_correct += 1
    accuracy_ratio = (total_correct / total_answered) if total_answered > 0 else 0
    print(f"Số câu đúng: {total_correct}")
    print(f"Số câu sai: {total_answered - total_correct}")
    print(f"Tỉ lệ đúng: {accuracy_ratio:.2%}")
    scaled_score = (total_correct / total_questions) * 10 if total_questions > 0 else 0
    return round(scaled_score, 2)

def save_total_score_to_db(id_bai_lam, total_score):
    bai_lam = BaiLam.objects.get(id=id_bai_lam)
    KetQua.objects.update_or_create(
        id_bai_lam=bai_lam,
        defaults={'diem': total_score}
    )

def grade_exam(image_path, id_bai_lam):
    import cv2
    img = cv2.imread(image_path)
    list_ans_boxes = crop_image(img)
    list_ans = process_ans_blocks(list_ans_boxes)
    list_answers = process_list_ans(list_ans)
    answers = get_answers(list_answers)

    for question, answer in answers.items():
        print(f"Câu hỏi {question}: {', '.join(answer)}")

    save_answers_to_db(answers, id_bai_lam)
    total_score = calculate_total_score(answers, id_bai_lam)
    save_total_score_to_db(id_bai_lam, total_score)

if __name__ == '__main__':
    grade_exam('D:/Python/Python-main/myproject/process/1.jpg', 3)
