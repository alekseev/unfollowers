function checker(){
	t = window.setInterval('getFollowers()', 300);
}
function getFollowers(){
	$.ajax({
		url: '/more',
		dataType: 'html',
		success: function(data){
			if (data != "0") {
				$("img.loader").addClass("hidden");
				clearInterval(t);
				$("ul.followers").html(data);
			}
		}
	});
}
function settings() {
	if ($("#settings").css("display") == "none"){
		$("#settings p.notice").text("");
		$("#settings").fadeIn(300);
	} else {
		$("#settings").fadeOut(300);
	}
	return false;
}
function save_settings() {
	var submit_button = $("#settings input[type='submit']");
	$(submit_button).val("Сохранение..");
	$(submit_button).attr("disabled", "disabled");
	$("#settings p.notice").text("Вжжжж..");
	$.post("/settings", $("#settings_form").serialize(), function(data){
		if (data == "email_not_changed"){
			$("#settings p.notice").text("Изменения сохранены!");
		} else if (data == "email_changed"){
			$("#notice_validated").removeClass("hidden");
			$("#settings p.notice").text("Изменения сохранены! Проверьте email, на него должна прийти ссылка для активации.");
		}
		$(submit_button).val("Сохранить");
		$(submit_button).removeAttr("disabled");
	});
}