<?php
// Configurar la zona local
date_default_timezone_set("America/Lima");

require_once '../models/Usuario.php';
require_once '../models/Funciones.php';

if (isset($_POST['operacion'])){

  $usuario = new Usuario();

  // ¿Que operación es?
  switch ($_POST['operacion']) {
    case 'listar':
      enviarJson($usuario->listar());
      break;
    case 'registrar':
      $archivo = date('Ymdhis');
      $nombreArchivo = sha1($archivo). ".jpg";
      $datosEnviar = [
        'idrol'             => $_POST['idrol'],
        'idnacionalidad'    => $_POST['idnacionalidad'],
        'avatar'            => '',
        'apellidos'         => $_POST['apellidos'],
        'nombres'           => $_POST['nombres'],
        'email'           => $_POST['email'],
        'claveacceso'       => password_hash($_POST["claveacceso"], PASSWORD_BCRYPT)
      ];
      if (isset($_FILES['avatar'])){
        if(move_uploaded_file($_FILES['avatar']['tmp_name'], "../imagesuser/" . $nombreArchivo)){
          $datosEnviar['avatar'] = $nombreArchivo;
        }
      }
      enviarJson($usuario->registrar($datosEnviar));
      break;
    case 'eliminar':
      $datosEnviar = [
        "idusuario" => $_POST["idusuario"]
      ];
      echo $usuario->eliminar($datosEnviar);
      break;
  }
}