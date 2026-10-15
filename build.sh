#/usr/bin/env bash
#exit on error
set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --noinput
python manage.py migrate

# Cargar los datos iniciales utilizando el script de Python de catálogos y departamentos
python manage.py shell < fixtures/datos_iniciales.py

# Ejecutar tu comando personalizado para asegurar el superusuario en producción
python manage.py ensure_admin --force

#Verificacion automatica
python manage.py shell -c "from administracion.models import Usuario; u = Usuario.objects.filter(username='adminITA').first(); u.correo_institucional_verificado = True; u.email_verificado = True; u.save()"