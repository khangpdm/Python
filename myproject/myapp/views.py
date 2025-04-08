import random
from django.shortcuts import render, redirect, get_object_or_404
from .models import NganHangCauHoi, DeThi, DeThiChiTiet
from .forms import CauHoiForm

def home(request):
    return render(request, 'index.html')

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
        ten_de = request.POST.get('ten_de', 'Đề thi mặc định')
        
        # Lấy tất cả câu hỏi từ ngân hàng
        tat_ca_cau_hoi = list(NganHangCauHoi.objects.all())
        
        if len(tat_ca_cau_hoi) < 50:
            error = "Ngân hàng câu hỏi chưa đủ 50 câu, hãy thêm câu hỏi vào hệ thống."
            return render(request, 'taodethi.html', {'error': error})
        
        # Chọn ngẫu nhiên 50 câu hỏi
        cau_hoi_chon = random.sample(tat_ca_cau_hoi, 50)
        
        # Tạo đề thi mới với tên đề
        de_thi = DeThi.objects.create(ten_de=ten_de)
        
        # Lưu từng câu hỏi vào chi tiết đề thi kèm thứ tự
        for index, cau_hoi in enumerate(cau_hoi_chon, start=1):
            DeThiChiTiet.objects.create(
                de_thi=de_thi,
                cau_hoi=cau_hoi,
                thu_tu=index
            )
        
        # Redirect đến trang chi tiết đề thi vừa tạo
        return redirect('chi_tiet_de_thi', de_thi_id=de_thi.id)
    
    return render(request, 'taodethi.html')

def chi_tiet_de_thi(request, de_thi_id):
    de_thi = get_object_or_404(DeThi, pk=de_thi_id)
    danh_sach_cau_hoi = DeThiChiTiet.objects.filter(de_thi=de_thi).order_by('thu_tu')
    return render(request, 'chitietdethi.html', {
        'de_thi': de_thi,
        'danh_sach_cau_hoi': danh_sach_cau_hoi
    })


from django.shortcuts import render
from django.http import HttpResponse
from .models import GiaoVien, HocSinh

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get("username").strip()
        password = request.POST.get("password").strip()

        gv = GiaoVien.objects.filter(username=username, password=password).first()
        hs = HocSinh.objects.filter(username=username, password=password).first()

        if gv:
            return HttpResponse(f"Đăng nhập thành công (Giáo viên: {gv.username})")
        elif hs:
            return HttpResponse(f"Đăng nhập thành công (Học sinh: {hs.username})")
        else:
            return HttpResponse("Sai tên đăng nhập hoặc mật khẩu!")
    
    return render(request, 'login.html')
