@echo off
REM انتقل لمجلد المشروع
cd /d E:\Flutter Projects\shelf_api

REM إضافة كل الملفات
git add .

REM عمل commit مع رسالة بتاريخ ووقت
git commit -m "update %date% %time%"

REM رفع التغييرات
git push origin main

echo Done!
pause