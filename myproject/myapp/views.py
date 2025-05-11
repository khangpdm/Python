import os
from django.shortcuts import render, redirect, get_object_or_404
from django.db import IntegrityError
from django.contrib import messages
from .models import NganHangCauHoi, DeThi, DeThiChiTiet, GiaoVien, HocSinh
from .forms import CauHoiForm


def home(request):
    role = request.session.get('role', '')
    username = request.session.get('username', '')
    login_success = bool(username)

    print("DEBUG - role:", role)
    print("DEBUG - username:", username)

    context = {
        'role': role,
        'username': username,
        'login_success': login_success
    }
    return render(request, 'index.html', context)

def cau_hoi_list(request):
    danh_sach_cau_hoi = NganHangCauHoi.objects.all()
    return render(request, 'cauhoilist.html', {'danh_sach_cau_hoi': danh_sach_cau_hoi})

def them_cau_hoi(request):
    if request.method == 'POST':
        form = CauHoiForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('cau_hoi_list')
    else:
        form = CauHoiForm()
    return render(request, 'cauhoiform.html', {'form': form})

def sua_cau_hoi(request, id):
    cauhoi = get_object_or_404(NganHangCauHoi, pk=id)
    if request.method == 'POST':
        form = CauHoiForm(request.POST, instance=cauhoi)
        if form.is_valid():
            form.save()
            return redirect('cau_hoi_list')
    else:
        form = CauHoiForm(instance=cauhoi)
    return render(request, 'cauhoiform.html', {'form': form})

def xoa_cau_hoi(request, id):
    cauhoi = get_object_or_404(NganHangCauHoi, pk=id)
    if request.method == 'POST':
        cauhoi.delete()
        return redirect('cau_hoi_list')
    return render(request, 'xoa_cauhoi.html', {'cauhoi': cauhoi})

def tao_de_thi(request):
    if request.method == 'POST':
        ma_de = request.POST.get('ma_de')
        ten_de = request.POST.get('ten_de')
        
        # Lấy username từ session
        username = request.session.get('username')
        role = request.session.get('role')

        # Kiểm tra đăng nhập và quyền giáo viên
        if not username or role != 'teacher':
            messages.error(request, 'Bạn cần đăng nhập với tư cách giáo viên để tạo đề.')
            return redirect('login')  # hoặc render('taodethi.html') tùy bạn

        # Tìm giáo viên theo username
        try:
            giao_vien = GiaoVien.objects.get(ten_dang_nhap=username)
            id_giao_vien = giao_vien.id
        except GiaoVien.DoesNotExist:
            messages.error(request, 'Không tìm thấy giáo viên.')
            return render(request, 'taodethi.html')

        # Kiểm tra mã đề đã tồn tại chưa
        if DeThi.objects.filter(ma_de=ma_de).exists():
            messages.error(request, 'Mã đề đã tồn tại. Vui lòng chọn mã khác.')
            return render(request, 'taodethi.html')

        try:
            de_thi = DeThi.objects.create(
                ma_de=ma_de,
                ten_de=ten_de,
                ngay_tao=timezone.now(),
                id_giao_vien=giao_vien
            )

            # Random 50 câu hỏi
            cau_hoi_ngau_nhien = list(NganHangCauHoi.objects.order_by('?')[:50])
            for thu_tu, cau_hoi in enumerate(cau_hoi_ngau_nhien, start=1):
                DeThiChiTiet.objects.create(
                    de_thi=de_thi,
                    cau_hoi=cau_hoi,
                    thu_tu=thu_tu
                )

            return redirect('xem_de_thi', id=de_thi.id)

        except IntegrityError:
            messages.error(request, 'Lỗi khi tạo đề. Có thể mã đề bị trùng.')
            return render(request, 'taodethi.html')

    return render(request, 'taodethi.html')

def chi_tiet_de_thi(request, de_thi_id):
    de_thi = get_object_or_404(DeThi, pk=de_thi_id)
    danh_sach_cau_hoi = DeThiChiTiet.objects.filter(de_thi=de_thi).order_by('thu_tu')
    return render(request, 'chitietdethi.html', {
        'de_thi': de_thi,
        'danh_sach_cau_hoi': danh_sach_cau_hoi
    })
    
def xem_de_thi(request, id):
    de_thi = get_object_or_404(DeThi, pk=id)
    danh_sach_cau_hoi = DeThiChiTiet.objects.filter(de_thi_id=id).select_related('cau_hoi').order_by('thu_tu')
    return render(request, 'chitietdethi.html', {
        'de_thi': de_thi,
        'danh_sach_cau_hoi': danh_sach_cau_hoi
    })


from .models import DeThi

def danh_sach_de_thi(request):
    # Lấy tất cả các đề thi
    danh_sach_de_thi = DeThi.objects.all().order_by('-ngay_tao')  # Sắp xếp theo ngày tạo, mới nhất trước

    # Trả về template kèm theo dữ liệu danh sách đề thi
    return render(request, 'danh_sach_de_thi.html', {
        'danh_sach_de_thi': danh_sach_de_thi
    })
    
def xoa_de_thi(request, id):
    de_thi = get_object_or_404(DeThi, pk=id)

    # Xoá các câu hỏi liên quanz
    DeThiChiTiet.objects.filter(de_thi=de_thi).delete()

    # Xoá đề
    de_thi.delete()
    messages.success(request, "Xoá đề thi thành công.")
    return redirect('danh_sach_de_thi')



import os
from fpdf import FPDF
import io
from django.http import FileResponse
from django.shortcuts import get_object_or_404
from .models import DeThi, DeThiChiTiet

def xuat_pdf_de_thi(request, id):
    de_thi = get_object_or_404(DeThi, pk=id)

    # Lấy danh sách câu hỏi theo thứ tự đã lưu
    danh_sach_cau_hoi = DeThiChiTiet.objects.filter(de_thi=de_thi).select_related('cau_hoi').order_by('thu_tu')

    # Tạo PDF
    pdf = FPDF(orientation='P', unit='mm', format='A4')
    pdf.add_page()

    # Đường dẫn đến font DejaVuSans.ttf trong thư mục static/fonts
    font_path = os.path.join('static', 'fonts', 'DejaVuSans.ttf')

    # Thêm font hỗ trợ Unicode
    pdf.add_font('DejaVu', '', font_path, uni=True)
    pdf.set_font('DejaVu', '', 12)

    # In tiêu đề
    pdf.cell(200, 10, txt=f"ĐỀ THI: {de_thi.ten_de}", ln=True, align='C')
    pdf.ln(10)

    # In từng câu hỏi và đáp án
    for ct in danh_sach_cau_hoi:
        thu_tu = ct.thu_tu
        cau = ct.cau_hoi

        pdf.multi_cell(0, 10, txt=f"Câu {thu_tu}: {cau.noi_dung}")
        pdf.cell(0, 10, txt=f"A. {cau.dap_an_A}", ln=True)
        pdf.cell(0, 10, txt=f"B. {cau.dap_an_B}", ln=True)
        pdf.cell(0, 10, txt=f"C. {cau.dap_an_C}", ln=True)
        pdf.cell(0, 10, txt=f"D. {cau.dap_an_D}", ln=True)
        pdf.ln(5)

    # Trả về file PDF
    buffer = io.BytesIO()
    pdf.output(buffer)
    buffer.seek(0)
    return FileResponse(buffer, as_attachment=True, filename=f"{de_thi.ten_de}.pdf")




from django.contrib.auth.hashers import check_password
from myapp.models import GiaoVien, HocSinh
from django.shortcuts import render, redirect
from django.contrib import messages

from myapp.models import GiaoVien, HocSinh
from django.shortcuts import render, redirect
from django.contrib import messages

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        # Kiểm tra tài khoản giáo viên từ bảng giao_vien
        try:
            teacher = GiaoVien.objects.get(ten_dang_nhap=username)
            if password == teacher.mat_khau:  # So sánh trực tiếp vì không mã hóa
                request.session['username'] = username
                request.session['role'] = 'teacher'
                return redirect('home')
            else:
                messages.error(request, 'Tên đăng nhập hoặc mật khẩu không đúng.')
        except GiaoVien.DoesNotExist:
            # Nếu không tìm thấy trong bảng giao_vien, kiểm tra bảng hoc_sinh
            try:
                student = HocSinh.objects.get(ten_dang_nhap=username)
                if password == student.mat_khau:  # So sánh trực tiếp vì không mã hóa
                    request.session['username'] = username
                    request.session['role'] = 'student'
                    return redirect('home')
                else:
                    messages.error(request, 'Tên đăng nhập hoặc mật khẩu không đúng.')
            except HocSinh.DoesNotExist:
                messages.error(request, 'Tên đăng nhập hoặc mật khẩu không đúng.')

    return render(request, 'index.html')


def logout_view(request):
    request.session.flush()
    return redirect('home')


def home_view(request):
    role = request.session.get('role', '')
    username = request.session.get('username', '')
    login_success = bool(username)

    print("DEBUG - role:", role)
    print("DEBUG - username:", username)
    
    from myapp.models import DeThi
    exams = DeThi.objects.all()

    context = {
        'role': role,
        'username': username,
        'login_success': login_success,
        'exams': exams
    }
    return render(request, 'index.html', context)




import os
import sys
import importlib.util
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.core.files.storage import FileSystemStorage
from django.utils import timezone
from django.db import connection
from .models import HocSinh, DeThi, NganHangCauHoi, BaiLam, ChiTietBaiLam, KetQua, GiaoVien, DeThiChiTiet
from .forms import CauHoiForm

import logging
logger = logging.getLogger(__name__)

def upload_exam(request):
    logger.info("Bắt đầu xử lý upload_exam")
    username = request.session.get('username')
    if not username:
        logger.error("Không có username trong session")
        messages.error(request, 'Bạn cần đăng nhập để nộp bài.')
        return redirect('login')
    
    try:
        hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        logger.info(f"Tìm thấy học sinh: {username}")
    except HocSinh.DoesNotExist:
        logger.error(f"Không tìm thấy học sinh: {username}")
        messages.error(request, 'Không tìm thấy học sinh.')
        return redirect('login')
    
    role = request.session.get('role')
    if role != 'student':
        logger.error(f"Vai trò không hợp lệ: {role}")
        messages.error(request, 'Chỉ học sinh mới có thể nộp bài.')
        return redirect('home')
    
    if request.method == 'POST':
        de_thi_id = request.POST.get('selected_exam')
        logger.info(f"Đề thi ID: {de_thi_id}")
        if not de_thi_id:
            logger.error("Không có đề thi được chọn")
            messages.error(request, 'Vui lòng chọn đề thi.')
            return redirect('home')
        
        try:
            de_thi = DeThi.objects.get(id=de_thi_id)
            logger.info(f"Tìm thấy đề thi: {de_thi.ten_de}")
        except DeThi.DoesNotExist:
            logger.error(f"Đề thi không tồn tại: {de_thi_id}")
            messages.error(request, 'Đề thi không tồn tại.')
            return redirect('home')
        
        if BaiLam.objects.filter(id_hoc_sinh=hoc_sinh, id_de=de_thi).exists():
            logger.error(f"Bài làm đã tồn tại cho học sinh {username} và đề thi {de_thi_id}")
            messages.error(request, 'Bạn đã nộp bài cho đề thi này.')
            return redirect('home')
        
        exam_file = request.FILES.get('exam_file')
        answers = request.POST.get('answers')
        if not exam_file and not answers:
            logger.error("Không có file bài làm hoặc đáp án")
            messages.error(request, 'Vui lòng chọn file bài làm hoặc nhập đáp án trắc nghiệm.')
            return redirect('home')
        
        fs = FileSystemStorage()
        filename = None
        if exam_file:
            if not exam_file.name.lower().endswith(('.png', '.jpg', '.jpeg')):
                logger.error(f"Định dạng file không hợp lệ: {exam_file.name}")
                messages.error(request, 'Vui lòng tải lên file ảnh PNG hoặc JPG.')
                return redirect('home')
            filename = fs.save(f'exam_submissions/{username}_{exam_file.name}', exam_file)
            logger.info(f"Lưu file bài làm: {filename}")
        
        bai_lam = BaiLam.objects.create(
            id_hoc_sinh=hoc_sinh,
            id_de=de_thi,
            trang_thai='dang_cho_cham',
            hinh_anh_bai_lam=filename
        )
        bai_lam_id = bai_lam.id
        logger.info(f"Tạo bài làm mới: ID {bai_lam_id}")
        
        try:
            if exam_file:
                process_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'process')
                if process_dir not in sys.path:
                    sys.path.insert(0, process_dir)
                process_img_path = os.path.join(process_dir, 'process_img.py')
                spec = importlib.util.spec_from_file_location("process_img", process_img_path)
                process_img = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(process_img)
                image_path = fs.path(filename)
                logger.info(f"Chấm bài thi tại: {image_path}")
                process_img.grade_exam(image_path, bai_lam_id)
            
            elif answers:
                import json
                answers_dict = json.loads(answers)
                logger.info(f"Xử lý đáp án trắc nghiệm: {answers_dict}")
                total_correct = 0
                total_questions = DeThiChiTiet.objects.filter(de_thi=de_thi).count()
                for cau_hoi_id, cau_tra_loi in answers_dict.items():
                    cau_hoi = NganHangCauHoi.objects.get(id=int(cau_hoi_id))
                    ket_qua = 'Đúng' if cau_tra_loi == cau_hoi.dap_an_dung else 'Sai'
                    if ket_qua == 'Đúng':
                        total_correct += 1
                    ChiTietBaiLam.objects.create(
                        id_bai_lam=bai_lam,
                        id_cau_hoi=cau_hoi,
                        cau_tra_loi=cau_tra_loi,
                        ket_qua=ket_qua
                    )
                diem = (total_correct / total_questions * 10) if total_questions > 0 else 0
                diem = round(diem, 2)
                KetQua.objects.create(id_bai_lam=bai_lam, diem=diem)
                bai_lam.trang_thai = 'da_cham'
                bai_lam.save()
                logger.info(f"Chấm điểm trắc nghiệm: {diem}")
            
            ket_qua = KetQua.objects.filter(id_bai_lam=bai_lam_id).first()
            diem = ket_qua.diem if ket_qua else 0
            logger.info(f"Kết quả bài làm: ID {bai_lam_id}, Điểm {diem}")
            messages.success(request, f'Đã nộp và chấm điểm bài thi (ID: {bai_lam_id}, Điểm: {diem})')
            return redirect('xem_ket_qua')
        
        except FileNotFoundError as e:
            logger.error(f"FileNotFoundError: {str(e)}")
            messages.error(request, f"Lỗi: Không tìm thấy file mô hình tại {str(e)}")
            return redirect('home')
        except Exception as e:
            logger.error(f"Lỗi xử lý bài thi: {str(e)}")
            messages.error(request, f"Lỗi xử lý bài thi: {str(e)}")
            return redirect('home')
    
    exams = DeThi.objects.all()
    return render(request, 'index.html', {'exams': exams, 'role': role, 'username': username})
    
def xem_ket_qua(request):
    username = request.session.get('username')
    role = request.session.get('role')
    if not username:
        messages.error(request, 'Bạn cần đăng nhập để xem kết quả.')
        return redirect('login')

    ket_qua_bai_lam = []

    if role == 'student':
        try:
            hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        except HocSinh.DoesNotExist:
            messages.error(request, 'Không tìm thấy học sinh.')
            return redirect('login')

        bai_lam_qs = BaiLam.objects.filter(id_hoc_sinh=hoc_sinh).select_related('id_de').order_by('-ngay_nop')
    elif role == 'teacher':
        bai_lam_qs = BaiLam.objects.all().select_related('id_de').order_by('-ngay_nop')
    else:
        messages.error(request, 'Bạn không có quyền xem kết quả.')
        return redirect('home')

    for bl in bai_lam_qs:
        ket_qua = KetQua.objects.filter(id_bai_lam=bl).first()
        question_ids = DeThiChiTiet.objects.filter(de_thi=bl.id_de).values_list('cau_hoi_id', flat=True)
        total_questions = len(question_ids)
        so_cau_dung = ChiTietBaiLam.objects.filter(id_bai_lam=bl, ket_qua='Đúng', id_cau_hoi__in=question_ids).count()
        so_cau_sai = ChiTietBaiLam.objects.filter(id_bai_lam=bl, ket_qua='Sai', id_cau_hoi__in=question_ids).count()
        so_cau_chua_tra_loi = total_questions - (so_cau_dung + so_cau_sai)
        ty_le_dung = (so_cau_dung / total_questions * 100) if total_questions > 0 else 0

        ket_qua_bai_lam.append({
            'id': bl.id,
            'ten_de': bl.id_de.ten_de,
            'ngay_nop': bl.ngay_nop,
            'trang_thai': bl.trang_thai,
            'diem': ket_qua.diem if ket_qua else None,
            'so_cau_dung': so_cau_dung,
            'so_cau_sai': so_cau_sai,
            'so_cau_chua_tra_loi': so_cau_chua_tra_loi,
            'ty_le_dung': round(ty_le_dung, 2)
        })

    return render(request, 'xem_ket_qua.html', {'ket_qua_bai_lam': ket_qua_bai_lam})

def mark_as_graded(request, bai_lam_id):
    username = request.session.get('username')
    role = request.session.get('role')
    if not username or role != 'teacher':
        messages.error(request, 'Bạn không có quyền thực hiện hành động này.')
        return redirect('xem_ket_qua')

    bai_lam = get_object_or_404(BaiLam, id=bai_lam_id)
    if bai_lam.trang_thai == 'dang_cho_cham':
        bai_lam.trang_thai = 'da_cham'
        bai_lam.save()
        messages.success(request, f'Bài làm ID {bai_lam_id} đã được đánh dấu là đã chấm.')
    else:
        messages.info(request, f'Bài làm ID {bai_lam_id} đã ở trạng thái {bai_lam.trang_thai}.')

    return redirect('xem_ket_qua')




# views.py
import os
from django.conf import settings
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from io import BytesIO
from .models import DeThi, DeThiChiTiet

def draw_wrapped_text(canvas, text, x, y, max_width, line_height):
    text = str(text).encode('utf-8').decode('utf-8')
    words = text.split()
    line = ""
    for word in words:
        if canvas.stringWidth(line + word, 'DejaVuSans', 12) < max_width:
            line += word + " "
        else:
            canvas.drawString(x, y, line.strip())
            y -= line_height
            line = word + " "
    if line:
        canvas.drawString(x, y, line.strip())
    return y

def xuat_pdf_de_thi(request, de_thi_id):
    # Kiểm tra quyền giáo viên
    username = request.session.get('username')
    role = request.session.get('role')
    if not username or role != 'teacher':
        messages.error(request, 'Bạn cần đăng nhập với tư cách giáo viên để xuất PDF.')
        return redirect('login')

    de_thi = get_object_or_404(DeThi, id=de_thi_id)
    danh_sach_cau_hoi = DeThiChiTiet.objects.filter(de_thi=de_thi).order_by('thu_tu')

    buffer = BytesIO()
    p = canvas.Canvas(buffer, pagesize=A4)

    # Thêm font hỗ trợ tiếng Việt
    font_path = os.path.join(settings.BASE_DIR, 'myapp', 'static', 'fonts', 'DejaVuSans.ttf')
    if not os.path.exists(font_path):
        raise FileNotFoundError(f"Font file not found at {font_path}. Please ensure DejaVuSans.ttf is placed in the myapp/static/fonts/ directory.")
    pdfmetrics.registerFont(TTFont('DejaVuSans', font_path))
    p.setFont('DejaVuSans', 12)

    # Ghi tiêu đề
    title = f"Đề thi: {de_thi.ten_de}"
    date = f"Ngày tạo: {de_thi.ngay_tao.strftime('%d/%m/%Y %H:%M')}"
    p.drawString(2 * cm, 28 * cm, title.encode('utf-8').decode('utf-8'))
    p.drawString(2 * cm, 27 * cm, date.encode('utf-8').decode('utf-8'))
    p.drawString(2 * cm, 26 * cm, "-" * 50)

    # Ghi danh sách câu hỏi
    y_position = 25 * cm
    for idx, chitiet in enumerate(danh_sach_cau_hoi, 1):
        cau_hoi = chitiet.cau_hoi
        y_position = draw_wrapped_text(p, f"Câu {idx}: {cau_hoi.noi_dung}", 2 * cm, y_position, 18 * cm, 0.5 * cm)
        y_position -= 1 * cm
        y_position = draw_wrapped_text(p, f"A. {cau_hoi.dap_an_A}", 3 * cm, y_position, 17 * cm, 0.5 * cm)
        y_position -= 0.5 * cm
        y_position = draw_wrapped_text(p, f"B. {cau_hoi.dap_an_B}", 3 * cm, y_position, 17 * cm, 0.5 * cm)
        y_position -= 0.5 * cm
        y_position = draw_wrapped_text(p, f"C. {cau_hoi.dap_an_C}", 3 * cm, y_position, 17 * cm, 0.5 * cm)
        y_position -= 0.5 * cm
        y_position = draw_wrapped_text(p, f"D. {cau_hoi.dap_an_D}", 3 * cm, y_position, 17 * cm, 0.5 * cm)
        y_position -= 1.5 * cm

        # Nếu hết trang, tạo trang mới
        if y_position < 2 * cm:
            p.showPage()
            p.setFont('DejaVuSans', 12)
            y_position = 28 * cm

    # Kết thúc và lưu PDF
    p.showPage()
    p.save()

    # Lưu file PDF vào thư mục media/pdfs/
    pdf_dir = os.path.join(settings.MEDIA_ROOT, 'pdfs')
    os.makedirs(pdf_dir, exist_ok=True)
    pdf_filename = f"DeThi_{de_thi.ma_de}.pdf"
    pdf_path = os.path.join(pdf_dir, pdf_filename)

    with open(pdf_path, 'wb') as f:
        f.write(buffer.getvalue())

    # Trả về file PDF để tải
    buffer.seek(0)
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="DeThi_{de_thi.ma_de}.pdf"'
    return response


# views.py
from django.http import FileResponse
from django.shortcuts import get_object_or_404

def xem_pdf_de_thi(request, de_thi_id):
    # Kiểm tra quyền giáo viên
    username = request.session.get('username')
    role = request.session.get('role')
    if not username or role != 'teacher':
        messages.error(request, 'Bạn cần đăng nhập với tư cách giáo viên để xem PDF.')
        return redirect('login')

    # Lấy thông tin đề thi
    de_thi = get_object_or_404(DeThi, id=de_thi_id)

    # Đường dẫn đến file PDF
    pdf_filename = f"DeThi_{de_thi.ma_de}.pdf"
    pdf_path = os.path.join(settings.MEDIA_ROOT, 'pdfs', pdf_filename)

    # Kiểm tra file PDF tồn tại
    if not os.path.exists(pdf_path):
        messages.error(request, 'File PDF không tồn tại. Vui lòng xuất PDF trước.')
        return redirect('danh_sach_de_thi')

    return FileResponse(open(pdf_path, 'rb'), content_type='application/pdf')



def chi_tiet_bai_lam(request, bai_lam_id):
    username = request.session.get('username')
    role = request.session.get('role')
    if not username:
        messages.error(request, 'Bạn cần đăng nhập để xem chi tiết bài làm.')
        return redirect('login')

    bai_lam = get_object_or_404(BaiLam, id=bai_lam_id)
    if role == 'student':
        hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        if bai_lam.id_hoc_sinh != hoc_sinh:
            messages.error(request, 'Bài làm không thuộc về bạn.')
            return redirect('xem_ket_qua')
    else:
        GiaoVien.objects.get(ten_dang_nhap=username)

    ket_qua = KetQua.objects.filter(id_bai_lam=bai_lam).first()
    chi_tiet = ChiTietBaiLam.objects.filter(id_bai_lam=bai_lam).select_related('id_cau_hoi')

    ket_qua_chi_tiet = [
        {
            'cau_hoi': ct.id_cau_hoi,
            'cau_tra_loi': ct.cau_tra_loi,
            'dap_an_dung': ct.id_cau_hoi.dap_an_dung,
            'ket_qua': ct.ket_qua
        } for ct in chi_tiet
    ]

    return render(request, 'chi_tiet_bai_lam.html', {
        'bai_lam': {
            'id': bai_lam.id,
            'de_thi': bai_lam.id_de,
            'hoc_sinh': bai_lam.id_hoc_sinh,
            'ngay_nop': bai_lam.ngay_nop,
            'trang_thai': bai_lam.trang_thai,
            'hinh_anh': bai_lam.hinh_anh_bai_lam,
            'diem': ket_qua.diem if ket_qua else None
        },
        'chi_tiet': ket_qua_chi_tiet,
        'role': role
    })

from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from io import BytesIO
from .models import HocSinh, DeThi, KetQua
from django.db import connection

def xuat_bao_cao_ket_qua(request, bai_lam_id):
    username = request.session.get('username')
    role = request.session.get('role')
    if not username:
        messages.error(request, 'Bạn cần đăng nhập để xuất báo cáo.')
        return redirect('login')

    # Kiểm tra quyền truy cập
    if role == 'student':
        hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT id, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam "
                "FROM bai_lam WHERE id = %s AND id_hoc_sinh = %s",
                [bai_lam_id, hoc_sinh.id]
            )
            bai_lam = cursor.fetchone()
            if not bai_lam:
                messages.error(request, 'Bài làm không tồn tại hoặc không thuộc về bạn.')
                return redirect('xem_ket_qua')
    else:
        GiaoVien.objects.get(ten_dang_nhap=username)
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT id, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam "
                "FROM bai_lam WHERE id = %s",
                [bai_lam_id]
            )
            bai_lam = cursor.fetchone()
            if not bai_lam:
                messages.error(request, 'Bài làm không tồn tại.')
                return redirect('xem_ket_qua_giao_vien')

    id_bai_lam, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam = bai_lam
    de_thi = DeThi.objects.get(id=id_de)
    hoc_sinh = HocSinh.objects.get(id=id_hoc_sinh)

    # Lấy chi tiết bài làm
    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT id_cau_hoi, cau_tra_loi, ket_qua FROM chi_tiet_bai_lam WHERE id_bai_lam = %s",
            [id_bai_lam]
        )
        chi_tiet = cursor.fetchall()

    ket_qua_chi_tiet = []
    for ct in chi_tiet:
        id_cau_hoi, cau_tra_loi, ket_qua = ct
        cau_hoi = NganHangCauHoi.objects.get(id=id_cau_hoi)
        ket_qua_chi_tiet.append({
            'cau_hoi': cau_hoi,
            'cau_tra_loi': cau_tra_loi,
            'dap_an_dung': cau_hoi.dap_an_dung,
            'ket_qua': ket_qua
        })

    ket_qua = KetQua.objects.filter(id_bai_lam=id_bai_lam).first()

    # Tạo PDF
    buffer = BytesIO()
    p = canvas.Canvas(buffer, pagesize=A4)

    # Thêm font hỗ trợ tiếng Việt
    font_path = os.path.join(settings.BASE_DIR, 'myapp', 'static', 'fonts', 'DejaVuSans.ttf')
    if not os.path.exists(font_path):
        raise FileNotFoundError(f"Font file not found at {font_path}.")
    pdfmetrics.registerFont(TTFont('DejaVuSans', font_path))
    p.setFont('DejaVuSans', 12)

    # Ghi tiêu đề
    p.drawString(2 * cm, 28 * cm, f"BÁO CÁO KẾT QUẢ BÀI LÀM #{id_bai_lam}")
    p.drawString(2 * cm, 27 * cm, f"Học sinh: {hoc_sinh.ten_dang_nhap}")
    p.drawString(2 * cm, 26 * cm, f"Đề thi: {de_thi.ten_de}")
    p.drawString(2 * cm, 25 * cm, f"Ngày nộp: {ngay_nop.strftime('%d/%m/%Y %H:%M')}")
    p.drawString(2 * cm, 24 * cm, f"Điểm: {ket_qua.diem if ket_qua else 'Chưa chấm'}")
    p.drawString(2 * cm, 23 * cm, "-" * 50)

    # Ghi chi tiết bài làm
    y_position = 22 * cm
    for idx, ct in enumerate(ket_qua_chi_tiet, 1):
        p.drawString(2 * cm, y_position, f"Câu {idx}: {ct['cau_hoi'].noi_dung}")
        y_position -= 0.5 * cm
        p.drawString(3 * cm, y_position, f"Đáp án chọn: {ct['cau_tra_loi']}")
        y_position -= 0.5 * cm
        p.drawString(3 * cm, y_position, f"Đáp án đúng: {ct['dap_an_dung']}")
        y_position -= 0.5 * cm
        p.drawString(3 * cm, y_position, f"Kết quả: {ct['ket_qua']}")
        y_position -= 1 * cm

        # Nếu hết trang, tạo trang mới
        if y_position < 2 * cm:
            p.showPage()
            p.setFont('DejaVuSans', 12)
            y_position = 28 * cm

    # Kết thúc và lưu PDF
    p.showPage()
    p.save()

    # Trả về file PDF
    buffer.seek(0)
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="BaoCaoKetQua_{id_bai_lam}.pdf"'
    return response




from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.hashers import make_password, check_password
from .models import HocSinh
from .forms import StudentRegistrationForm

def them_hoc_sinh(request):
    if request.session.get('role') != 'teacher':
        messages.error(request, 'Chỉ giáo viên mới có thể thêm học sinh.')
        return redirect('home')

    if request.method == 'POST':
        form = StudentRegistrationForm(request.POST)
        if form.is_valid():
            ten_dang_nhap = form.cleaned_data['ten_dang_nhap']
            mat_khau = form.cleaned_data['mat_khau']  
            HocSinh.objects.create(
                ten_dang_nhap=ten_dang_nhap,
                mat_khau=mat_khau,
                dark_mode=0
            )
            messages.success(request, f'Tài khoản học sinh "{ten_dang_nhap}" đã được tạo thành công.')
            return redirect('home')
        else:
            messages.error(request, 'Vui lòng kiểm tra lại thông tin.')
    else:
        form = StudentRegistrationForm()

    return render(request, 'them_hoc_sinh.html', {'form': form})