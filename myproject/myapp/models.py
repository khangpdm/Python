# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class NganHangCauHoi(models.Model):
    noi_dung = models.TextField()
    dap_an_A = models.TextField(db_column='dap_an_A')
    dap_an_B = models.TextField(db_column='dap_an_B')
    dap_an_C = models.TextField(db_column='dap_an_C')
    dap_an_D = models.TextField(db_column='dap_an_D')
    dap_an_dung = models.CharField(max_length=1, choices=[('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')], null=True, blank=True)

    class Meta:
        managed = False
        db_table = 'ngan_hang_cau_hoi'
        
class DeThi(models.Model):
    id = models.AutoField(primary_key=True)
    ten_de = models.CharField(max_length=255)
    ma_de = models.CharField(max_length=20)
    ngay_tao = models.DateTimeField(auto_now_add=True)
    id_giao_vien = models.ForeignKey('GiaoVien', db_column='id_giao_vien', on_delete=models.CASCADE)  

    class Meta:
        db_table = 'de_thi'
        managed = False


class DeThiChiTiet(models.Model):
    de_thi = models.ForeignKey('DeThi', on_delete=models.CASCADE, db_column='de_thi_id')
    cau_hoi = models.ForeignKey('NganHangCauHoi', on_delete=models.CASCADE, db_column='cau_hoi_id')
    thu_tu = models.IntegerField()

    class Meta:
        db_table = 'de_thi_chi_tiet'
        managed = False

        
class KetQua(models.Model):
    id = models.AutoField(primary_key=True)
    id_bai_lam = models.ForeignKey('BaiLam', on_delete=models.CASCADE, null=True, db_column='id_bai_lam')
    diem = models.FloatField(null=True, blank=True)

    class Meta:
        db_table = 'ket_qua'
        managed = False

# models.py
from django.db import models

class GiaoVien(models.Model):
    id = models.AutoField(primary_key=True)
    ten_dang_nhap = models.CharField(max_length=50, unique=True)
    mat_khau = models.CharField(max_length=255)

    class Meta:
        db_table = 'giao_vien'
        managed = False

class HocSinh(models.Model):
    id = models.AutoField(primary_key=True)
    ten_dang_nhap = models.CharField(max_length=50, unique=True)
    mat_khau = models.CharField(max_length=255)

    class Meta:
        db_table = 'hoc_sinh'
        managed = False




from django.db import models

class BaiLam(models.Model):
    id = models.AutoField(primary_key=True)
    id_hoc_sinh = models.ForeignKey('HocSinh', on_delete=models.CASCADE, null=True, db_column='id_hoc_sinh')
    id_de = models.ForeignKey('DeThi', on_delete=models.CASCADE, null=True, db_column='id_de')
    ngay_nop = models.DateTimeField(auto_now_add=True)
    trang_thai = models.CharField(max_length=20, choices=[('dang_cho_cham', 'Đang chờ chấm'), ('da_cham', 'Đã chấm')], default='dang_cho_cham')
    hinh_anh_bai_lam = models.FileField(upload_to='exam_submissions/', null=True, blank=True)

    class Meta:
        managed = False
        db_table = 'bai_lam'

class ChiTietBaiLam(models.Model):
    id = models.AutoField(primary_key=True)
    id_bai_lam = models.ForeignKey('BaiLam', on_delete=models.CASCADE, null=True, db_column='id_bai_lam')
    id_cau_hoi = models.ForeignKey('NganHangCauHoi', on_delete=models.CASCADE, null=True, db_column='id_cau_hoi')
    cau_tra_loi = models.CharField(max_length=255, null=True, blank=True)
    ket_qua = models.CharField(max_length=10, choices=[('Đúng', 'Đúng'), ('Sai', 'Sai')], null=True, blank=True)

    class Meta:
        managed = False
        db_table = 'chi_tiet_bai_lam'
