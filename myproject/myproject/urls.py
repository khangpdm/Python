"""
URL configuration for myproject project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from myapp.views import home, cau_hoi_list  # Import thêm view cau_hoi_list
from myapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home_view, name='home'),
    path('cau-hoi/', cau_hoi_list, name='cau_hoi_list'),  # Thêm đường dẫn mới
    path('cau-hoi/them/', views.them_cau_hoi, name='them_cau_hoi'),
    path('cau-hoi/sua/<int:id>/', views.sua_cau_hoi, name='sua_cau_hoi'),
    path('cau-hoi/xoa/<int:id>/', views.xoa_cau_hoi, name='xoa_cau_hoi'),
    path('tao-de-thi/', views.tao_de_thi, name='tao_de_thi'),
    path('de-thi/<int:de_thi_id>/', views.chi_tiet_de_thi, name='chi_tiet_de_thi'),
    path('de-thi/<int:id>/', views.xem_de_thi, name='xem_de_thi'),
    path('danh-sach-de-thi/', views.danh_sach_de_thi, name='danh_sach_de_thi'),
    path('de-thi/<int:id>/', views.xem_de_thi, name='xem_de_thi'),  # Xem chi tiết đề thi
    path('xoa-de-thi/<int:id>/', views.xoa_de_thi, name='xoa_de_thi'),
    path('xuat-pdf-de-thi/<int:id>/', views.xuat_pdf_de_thi, name='xuat_pdf_de_thi'),
    
    path('', views.home_view, name='home'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('upload-exam/', views.upload_exam, name='upload_exam'),
    path('xem-ket-qua/', views.xem_ket_qua, name='xem_ket_qua'),
    path('xuat_pdf_de_thi/<int:de_thi_id>/', views.xuat_pdf_de_thi, name='xuat_pdf_de_thi'),
    path('xem_pdf_de_thi/<int:de_thi_id>/', views.xem_pdf_de_thi, name='xem_pdf_de_thi'),
]
