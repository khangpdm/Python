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
        id_giao_vien = request.POST.get('id_giao_vien') or 1  # hardcoded tạm

        # Kiểm tra mã đề đã tồn tại chưa
        if DeThi.objects.filter(ma_de=ma_de).exists():
            messages.error(request, 'Mã đề đã tồn tại. Vui lòng chọn mã khác.')
            return render(request, 'taodethi.html')

        try:
            de_thi = DeThi.objects.create(
                ma_de=ma_de,
                ten_de=ten_de,
                ngay_tao=timezone.now(),
                id_giao_vien=id_giao_vien
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








# views.py
# views.py


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

    context = {
        'role': role,
        'username': username,
        'login_success': login_success
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