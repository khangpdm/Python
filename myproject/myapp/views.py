import os
import sys
import random
import random
from django.shortcuts import render, redirect, get_object_or_404
from django.db import IntegrityError
from django.contrib import messages
from .models import NganHangCauHoi, DeThi, DeThiChiTiet, GiaoVien, HocSinh
from .forms import CauHoiForm
from django.utils import timezone


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

    # Xoá các câu hỏi liên quan
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




# views.py
from myapp.models import GiaoVien, HocSinh

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        try:
            teacher = GiaoVien.objects.get(ten_dang_nhap=username, mat_khau=password)
            request.session['username'] = teacher.ten_dang_nhap
            request.session['role'] = 'teacher'
            return redirect('home')
        except GiaoVien.DoesNotExist:
            pass

        try:
            student = HocSinh.objects.get(ten_dang_nhap=username, mat_khau=password)
            request.session['username'] = student.ten_dang_nhap
            request.session['role'] = 'student'
            return redirect('home')
        except HocSinh.DoesNotExist:
            pass

        return render(request, 'index.html', {
            'error': 'Sai tài khoản hoặc mật khẩu!',
            'login_success': False
        })

    return redirect('home')


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


from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
import os
from django.conf import settings

def upload_exam(request):
    if request.method == 'POST' and request.user.is_authenticated:
        if 'exam_file' in request.FILES:
            exam_file = request.FILES['exam_file']
            file_path = os.path.join(settings.MEDIA_ROOT, 'exam_submissions', exam_file.name)
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            with open(file_path, 'wb+') as destination:
                for chunk in exam_file.chunks():
                    destination.write(chunk)
            messages.success(request, f'Đã nộp bài thi: {exam_file.name}')
        else:
            messages.error(request, 'Vui lòng chọn file để nộp.')
        return redirect('home')
    return redirect('login')

from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
import os
from django.conf import settings


from django.conf import settings
from django.db import connection
from myapp.models import HocSinh, DeThi
import datetime


def upload_exam(request):
    import os
    import importlib.util
    from django.conf import settings
    from django.db import connection
    from myapp.models import HocSinh, DeThi
    import datetime
    from django.contrib import messages
    from django.shortcuts import redirect, render

    if request.method == 'POST':
        username = request.session.get('username')
        if not username:
            messages.error(request, 'Bạn cần đăng nhập để nộp bài thi.')
            return redirect('login')

        try:
            hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        except HocSinh.DoesNotExist:
            messages.error(request, 'Không tìm thấy học sinh.')
            return redirect('login')

        selected_exam_id = request.POST.get('selected_exam')
        try:
            de_thi = DeThi.objects.get(id=selected_exam_id)
        except (DeThi.DoesNotExist, ValueError, TypeError):
            messages.error(request, 'Đề thi không hợp lệ.')
            return redirect('home')

        if 'exam_file' in request.FILES:
            exam_file = request.FILES['exam_file']
            from django.core.files.storage import FileSystemStorage
            fs = FileSystemStorage(location=os.path.join(settings.MEDIA_ROOT, 'exam_submissions'))
            filename = fs.save(exam_file.name, exam_file)
            file_path = fs.path(filename)

            # Lưu bài làm vào cơ sở dữ liệu trước
            with connection.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO bai_lam (id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam) VALUES (%s, %s, %s, %s, %s)",
                    [hoc_sinh.id, de_thi.id, datetime.datetime.now(), 'dang_cho_cham', file_path]
                )
                bai_lam_id = cursor.lastrowid

            # Xử lý hình ảnh bài thi với xử lý lỗi
            try:
                process_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'process')
                if process_dir not in sys.path:
                    sys.path.insert(0, process_dir)
                process_img_path = os.path.join(process_dir, 'process_img.py')
                spec = importlib.util.spec_from_file_location("process_img", process_img_path)
                process_img = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(process_img)
                
                image_path = file_path
                process_img.grade_exam(image_path, bai_lam_id)
                messages.success(request, f'Đã nộp và xử lý bài thi: {exam_file.name} (bài làm id: {bai_lam_id})')
            except FileNotFoundError as e:
                messages.error(request, f"Lỗi: Không tìm thấy file mô hình tại {str(e)}")
            except Exception as e:
                messages.error(request, f"Lỗi xử lý bài thi: {str(e)}")

            return redirect('xem_ket_qua')  # Chuyển hướng dù có lỗi hay không
        else:
            messages.error(request, 'Vui lòng chọn file để nộp.')
            return redirect('home')
    else:
        exams = DeThi.objects.all()
        return render(request, 'index.html', {'exams': exams})
    
def xem_ket_qua(request):
    username = request.session.get('username')
    if not username:
        messages.error(request, 'Bạn cần đăng nhập để xem kết quả.')
        return redirect('login')

    try:
        hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
    except HocSinh.DoesNotExist:
        messages.error(request, 'Không tìm thấy học sinh.')
        return redirect('login')

    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT bl.id, dt.ten_de, bl.ngay_nop, bl.trang_thai, kq.diem "
            "FROM bai_lam bl "
            "JOIN de_thi dt ON bl.id_de = dt.id "
            "LEFT JOIN ket_qua kq ON bl.id = kq.id_bai_lam "
            "WHERE bl.id_hoc_sinh = %s "
            "ORDER BY bl.ngay_nop DESC",
            [hoc_sinh.id]
        )
        ket_qua_bai_lam_raw = cursor.fetchall()

    # Lọc điểm chỉ khi trạng thái là 'da_cham', ngược lại điểm là None hoặc 0
    ket_qua_bai_lam = []
    for bl in ket_qua_bai_lam_raw:
        id_bai_lam, ten_de, ngay_nop, trang_thai, diem = bl
        if trang_thai == 'da_cham':
            ket_qua_bai_lam.append(bl)
        else:
            ket_qua_bai_lam.append((id_bai_lam, ten_de, ngay_nop, trang_thai, None))

    return render(request, 'xem_ket_qua.html', {'ket_qua_bai_lam': ket_qua_bai_lam})




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



from django.db import connection
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import HocSinh, DeThi, NganHangCauHoi, KetQua, GiaoVien

def chi_tiet_bai_lam(request, bai_lam_id):
    username = request.session.get('username')
    role = request.session.get('role')
    if not username:
        messages.error(request, 'Bạn cần đăng nhập để xem chi tiết bài làm.')
        return redirect('login')

    if role == 'student':
        hoc_sinh = HocSinh.objects.get(ten_dang_nhap=username)
        with connection.cursor() as cursor:
            cursor.execute("SELECT id, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam FROM bai_lam WHERE id = %s AND id_hoc_sinh = %s", [bai_lam_id, hoc_sinh.id])
            bai_lam = cursor.fetchone()
            if not bai_lam:
                messages.error(request, 'Bài làm không tồn tại hoặc không thuộc về bạn.')
                return redirect('xem_ket_qua')
    else:
        GiaoVien.objects.get(ten_dang_nhap=username)
        with connection.cursor() as cursor:
            cursor.execute("SELECT id, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam FROM bai_lam WHERE id = %s", [bai_lam_id])
            bai_lam = cursor.fetchone()
            if not bai_lam:
                messages.error(request, 'Bài làm không tồn tại.')
                return redirect('xem_ket_qua_giao_vien')

    id_bai_lam, id_hoc_sinh, id_de, ngay_nop, trang_thai, hinh_anh_bai_lam = bai_lam
    de_thi = DeThi.objects.get(id=id_de)
    hoc_sinh = HocSinh.objects.get(id=id_hoc_sinh)

    with connection.cursor() as cursor:
        cursor.execute("SELECT id_cau_hoi, cau_tra_loi, ket_qua FROM chi_tiet_bai_lam WHERE id_bai_lam = %s", [id_bai_lam])
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
    return render(request, 'chi_tiet_bai_lam.html', {
        'bai_lam': {'id': id_bai_lam, 'de_thi': de_thi, 'hoc_sinh': hoc_sinh, 'ngay_nop': ngay_nop, 'trang_thai': trang_thai, 'hinh_anh': hinh_anh_bai_lam, 'diem': ket_qua.diem if ket_qua else None},
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
    p.drawString(2 * cm, 27 * cm, f"Học sinh: {hoc_sinh.ho_ten}")
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