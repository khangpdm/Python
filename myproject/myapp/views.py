from django.shortcuts import render, redirect, get_object_or_404
from .models import NganHangCauHoi
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