from django.shortcuts import render
from .models import NganHangCauHoi  # Import model của bạn

def cau_hoi_list(request):
    # Lấy tất cả dữ liệu từ bảng ngan_hang_cau_hoi
    cau_hoi = NganHangCauHoi.objects.all()
    return render(request, 'cauhoilist.html', {'cau_hoi': cau_hoi})


def home(request):
    return render(request, 'index.html')  # Đảm bảo file HTML được gọi đúng
