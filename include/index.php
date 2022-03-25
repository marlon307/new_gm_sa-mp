<?php
	if(!isset($_GET['autenticado'])) {
		if(!isset($_POST['de']) || !isset($_POST['para']) || !isset($_POST['tit']) || !isset($_POST['msg']))
			die ("ERRO - MAIL DESAUTENTICADO");
		$charset = $_POST['charset'];
		$de = $_POST['de'];
		$para = $_POST['para'];
		if($charset == "utf-8") {			
			$titulo = utf8_encode($_POST['tit']);
			$msg = utf8_encode($_POST['msg']);
		} else {
			$titulo = $_POST['tit'];
			$msg = $_POST['msg'];
		}
		$type = $_POST['type'];
		$headers = "MIME-Version: 1.1\r\n";
		$headers .= "Content-type: $type; charset=$charset\r\n";
		$headers .= "From: $de\r\n"; // remetente
		$headers .= "Return-Path: $de\r\n"; // return-path	
		$envio = mail($para, $titulo, $msg, $headers);
		if(!$envio) echo 'E-mail não enviado.';
		else echo 'E-mail enviado';
	}
	else {
		if(!isset($_POST['de']) || !isset($_POST['senha']) || !isset($_POST['host']) || !isset($_POST['porta']) || !isset($_POST['para']) || !isset($_POST['tit']) || !isset($_POST['msg']))
			die ("ERRO - MAIL AUTENTICADO");
		include ("phpmailer/PHPMailerAutoload.php"); 
		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->SetLanguage("br");
		$mail->CharSet = $_POST['charset'];
		$mail->Username = $_POST['de'];
		$mail->From = $_POST['de'];
		$mail->FromName = $_POST['de'];
		$mail->Password = $_POST['senha'];	
		$mail->Host = $_POST['host'];
		$mail->Port = $_POST['porta'];
		$mail->SMTPAuth = true;
		$mail->AuthType = $_POST['auth'];
		if($_POST['charset'] == "utf-8") {
			$mail->Subject = utf8_encode($_POST['tit']);
			$mail->Body = utf8_encode($_POST['msg']);
			$mail->AltBody = utf8_encode($_POST['msg']);
		} else {
			$mail->Subject = $_POST['tit'];
			$mail->Body = $_POST['msg'];
			$mail->AltBody = $_POST['msg'];		
		}
		
		$mail->IsHTML((($_POST['type'] == "text/html") ? (true) : (false)));
		$mail->AddAddress($_POST['para']);
		$envio = $mail->Send();	
		if(!$envio) echo 'E-mail não enviado';
		else echo 'E-mail enviado';
	}

?>