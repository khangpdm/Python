from django.shortcuts import render

def home(request):
    return render(request, 'index.html')  # Đảm bảo file HTML được gọi đúng
