import imutils
import numpy as np
import cv2
from math import ceil
from model_test import SimpleCNN
from collections import defaultdict
import torch
import mysql.connector  # Thư viện để kết nối MySQL

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

    if len(list_choices) != 200:  # 50 câu hỏi x 4 lựa chọn = 200
        raise ValueError(f"Length of list_choices must be 200, but got {len(list_choices)}")

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


import os
from collections import defaultdict
import torch
import numpy as np
from model_test import SimpleCNN

def get_answers(list_answers):
    results = defaultdict(list)
    model = SimpleCNN('model_weight.pth')
    
    # Sử dụng đường dẫn tương đối
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    model_path = os.path.join(BASE_DIR, 'process', 'model_weight.pth')
    
    # Kiểm tra file có tồn tại không
    if not os.path.exists(model_path):
        raise FileNotFoundError(f"Không tìm thấy file mô hình tại: {model_path}. Vui lòng đặt file 'model_weight.pth' vào thư mục {os.path.dirname(model_path)}")
    
    # Tải mô hình với xử lý lỗi
    try:
        model.load_state_dict(torch.load(model_path, weights_only=True))
    except Exception as e:
        raise Exception(f"Lỗi khi tải mô hình: {str(e)}")
    
    model.eval()  # Set model to evaluation mode

    list_answers = np.array(list_answers)

    with torch.no_grad():
        scores = model(torch.tensor(list_answers, dtype=torch.float32).permute(0, 3, 1, 2) / 255.0)

    for idx, score in enumerate(scores):
        question = idx // 4
        if score[1] > 0.9:
            chosed_answer = map_answer(idx)
            results[question + 1].append(chosed_answer)

    return results


def get_correct_answer(question_id):
    # Kết nối đến cơ sở dữ liệu để lấy câu trả lời đúng
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='tnonlinefix'
        )
        cursor = connection.cursor()
        
        sql = "SELECT dap_an_dung FROM ngan_hang_cau_hoi WHERE id = %s"
        cursor.execute(sql, (question_id,))
        result = cursor.fetchone()
        
        if result:
            return result[0]  # Trả về câu trả lời đúng
        else:
            return None  # Không tìm thấy câu hỏi

    except mysql.connector.Error as err:
        print(f"Lỗi: {err}")
        return None
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def save_answers_to_db(answers, id_bai_lam):
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='tnonlinefix'
        )
        cursor = connection.cursor()

        # Lấy id_de từ bai_lam
        cursor.execute("SELECT id_de FROM bai_lam WHERE id = %s", (id_bai_lam,))
        id_de = cursor.fetchone()[0]

        # Lấy danh sách câu hỏi của đề thi
        cursor.execute("SELECT cau_hoi_id, thu_tu FROM de_thi_chi_tiet WHERE de_thi_id = %s ORDER BY thu_tu", (id_de,))
        cau_hoi_list = cursor.fetchall()

        for thu_tu, answer_list in answers.items():
            if thu_tu > len(cau_hoi_list):
                continue  # Bỏ qua nếu số thứ tự vượt quá số câu hỏi
            cau_hoi_id = cau_hoi_list[thu_tu - 1][0]
            correct_answer = get_correct_answer(cau_hoi_id)
            if len(answer_list) > 1:
                combined_answer = ', '.join(answer_list)
                ket_qua = 'Sai'
            else:
                combined_answer = answer_list[0] if answer_list else None
                ket_qua = 'Đúng' if combined_answer == correct_answer else 'Sai'

            if combined_answer:
                cursor.execute(
                    "INSERT INTO chi_tiet_bai_lam (id_bai_lam, id_cau_hoi, cau_tra_loi, ket_qua) VALUES (%s, %s, %s, %s)",
                    (id_bai_lam, cau_hoi_id, combined_answer, ket_qua)
                )

        connection.commit()
    except mysql.connector.Error as err:
        print(f"Lỗi: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def calculate_total_score(answers, id_bai_lam):
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='tnonlinefix'
        )
        cursor = connection.cursor()

        cursor.execute("SELECT id_de FROM bai_lam WHERE id = %s", (id_bai_lam,))
        id_de = cursor.fetchone()
        if not id_de:
            raise ValueError("Không tìm thấy bài làm với ID này.")
        id_de = id_de[0]

        cursor.execute("SELECT COUNT(*) FROM de_thi_chi_tiet WHERE de_thi_id = %s", (id_de,))
        total_questions = cursor.fetchone()[0]

        total_correct = 0
        for thu_tu, answer_list in answers.items():
            if thu_tu > total_questions:
                continue
            cau_hoi_id = cursor.execute(
                "SELECT cau_hoi_id FROM de_thi_chi_tiet WHERE de_thi_id = %s AND thu_tu = %s",
                (id_de, thu_tu)
            ).fetchone()
            if cau_hoi_id and len(answer_list) == 1:
                answer = answer_list[0]
                correct_answer = get_correct_answer(cau_hoi_id[0])
                if answer == correct_answer:
                    total_correct += 1

        scaled_score = (total_correct / total_questions * 10) if total_questions > 0 else 0
        scaled_score = round(scaled_score, 2)
        return scaled_score, total_questions, total_correct
    except mysql.connector.Error as err:
        print(f"Lỗi: {err}")
        return 0, 0, 0
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()



def save_total_score_to_db(id_bai_lam, total_score):
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='tnonlinefix'
        )
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO ket_qua (id_bai_lam, diem) VALUES (%s, %s) ON DUPLICATE KEY UPDATE diem = %s",
            (id_bai_lam, total_score, total_score)
        )
        cursor.execute(
            "UPDATE bai_lam SET trang_thai = 'da_cham' WHERE id = %s",
            (id_bai_lam,)
        )
        connection.commit()
    except mysql.connector.Error as err:
        print(f"Lỗi khi lưu điểm tổng: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

import logging
logger = logging.getLogger(__name__)

def grade_exam(image_path, id_bai_lam):
    logger.info(f"Bắt đầu chấm bài thi: {image_path}, ID: {id_bai_lam}")
    img = cv2.imread(image_path)
    if img is None:
        logger.error(f"Không thể đọc hình ảnh từ: {image_path}")
        raise ValueError(f"Không thể đọc hình ảnh từ: {image_path}")
    
    list_ans_boxes = crop_image(img)
    logger.info(f"Tìm thấy {len(list_ans_boxes)} khối đáp án")
    
    list_ans = process_ans_blocks(list_ans_boxes)
    logger.info(f"Xử lý {len(list_ans)} đáp án")
    
    list_answers = process_list_ans(list_ans)
    logger.info(f"Chuẩn bị {len(list_answers)} lựa chọn cho mô hình")
    
    answers = get_answers(list_answers)
    logger.info(f"Kết quả nhận diện: {answers}")
    
    save_answers_to_db(answers, id_bai_lam)
    total_score, total_questions, total_correct = calculate_total_score(answers, id_bai_lam)
    save_total_score_to_db(id_bai_lam, total_score)
    
    logger.info(f"Tổng số câu hỏi: {total_questions}, Số câu đúng: {total_correct}, Điểm: {total_score}")
    return total_score