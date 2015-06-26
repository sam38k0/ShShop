
//Event Function
//
function addEvent(el, event, callback) {
	if ('addEventListener' in el) {
		el.addEventListener(event, callback, false);
	} else {
		el['e' + event + callback] = callback;
		el[event + callback] = function() {
			el['e' + event + callback](window.event);
		};

		el.attachEvent('on' + event, el[event + callback]);
	}
}


//Validation Check
//
function validateRequired(el) {
	if (isRequired(el)) {
		var valid = !isEmpty(el);
		if (!valid) {
			setErrorMessage(el, '이  필드는  필수입력 필드입니다.');
		}
		return valid;
	}
	return true;
}

function isRequired(el) {
	return ((typeof el.required === 'boolean') && el.required) || (typeof el.required === 'string');
}

function isEmpty(el) {
	return !el.value || el.value === el.placeholder;
}

function validateTypes(el) {
	if (!el.value)
		return true;

	var type = $(el).data('type') || el.getAttribute('type');
	if(type === 'submit' || type === 'button')
		return true;
	
	if (typeof validateType[type] === 'function') {
		return validateType[type](el);
	} else {
		return true;
	}
}

function validateBio() {
	var bio = document.getElementById('bio-reg');
	var valid = bio.value.length <= 140;
	if (!valid) {
		setErrorMessage(bio, 'Bio 필드는 140 자를 넘을 수 없습니다.');
	}
	return valid;
}

function validatePassword() {
	var password = document.getElementById('password-reg');
	var valid = password.value.length >= 8;
	if (!valid) {
		setErrorMessage(password, '패스워드는 8자 이상이여야 합니다.');
	}
	return valid;
}


//Error Message
//
function setErrorMessage(el, message) {
	$(el).data('errorMessage', message);
}

function getErrorMessage(el) {
	return $(el).data('errorMessage') || el.title;
}

function showErrorMessage(el) {
	var $el = $(el);
	var errorContainer = $el.siblings('.error.message');

	if (!errorContainer.length) {
		errorContainer = $('<span class="error message"></span>').insertAfter($el);
	}
	errorContainer.text(getErrorMessage(el));
}

function removeErrorMessage(el) {
	var errorContainer = $(el).siblings('.error.message');
	errorContainer.remove();
}


function loginAreaEnter(e) {
	var code = (e.keyCode ? e.keyCode : e.which);

	if (code != 13)
		return;
	
	var text = $(this).val();
	if (text === null || text === '')
		return;
	
	text = $('#email').val();
	if (text === null  || text === '')
		return;

	$('#loginBtn').trigger('click');
}


// ////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	//로그인 > 유효성 체크를 서블릿에서 함
	//
	(function() {
		$("#loginBtn").click(function() {
			var form_data = {
				email : $("#email").val(),
				password : $("#pwd").val(),
				is_ajax : 1
			};

			$.ajax({
				type : "POST",
				url : "login",
				data : form_data,
				success : function(text) {
					response = text;
					response = $.parseJSON(text);
					if (typeof response != 'undefined') {
						$("#email").val('');
						$("#pwd").val('');
						$("#message").val('');
						$(".gnb_before_login").hide()
						$(".gnb_after_login").show();
						$("#link").show();
						$("#virtualOrderHeader").text('BASKET(' + response.virtualOrderCount + ')');
						modal.close();
					} else {
						$("#email").val('');
						$("#pwd").val('');
						$(".gnb_before_login").show()
						$(".gnb_after_login").hide();
						$("#link").hide();
						$("#message").html("<p style='color:white'> 아이디 또는 비밀번호가 잘못되었습니다.</p>");
					}
				},
				fail : function() {
					$("#message").html("<p style='color:white'>데이터를 로딩하지 못했습니다.</p>");
				}
			});

			return false;
		});
	}());
	
	(function() {
		$("#email").keyup(loginAreaEnter);
		$("#pwd").keyup(loginAreaEnter);
	}());

	//로그아웃
	//
	(function() {
		$("#share_logout").on('click', function() {
			$.ajax({
				type : "POST",
				url : "logout",
				success : function(text) {
					response = text;
					$(".gnb_before_login").show();
					$(".gnb_after_login").hide();
					location.href = 'viewMain';
				}
			});

			return false;
		});
	}());

	//회원가입 > 기본 유효성 검사를 자바스크립트로 처리
	//
	(function() {
		document.forms.registerForm.noValidate = true;

		$('#registerForm').on('submit', function(e) {
			var elements = this.elements;
			var valid = {};
			var isValid;
			var isFormValid;

			var i;
			for (i = 0, l = elements.length; i < l; i++) {

				isValid = validateRequired(elements[i]) && validateTypes(elements[i]);
				if (!isValid) {
					showErrorMessage(elements[i]);
				} else {
					removeErrorMessage(elements[i]);
				}
				valid[elements[i].id] = isValid;
			}

			if (!validateBio()) {
				showErrorMessage(document.getElementById('bio-reg'));
				valid.bio = false;
			} else {
				removeErrorMessage(document.getElementById('bio-reg'));
			}

			if (!validatePassword()) {
				showErrorMessage(document.getElementById('password-reg'));
				valid.password = false;
			} else {
				removeErrorMessage(document.getElementById('password-reg'));
			}

			for ( var field in valid) {
				if (!valid[field]) {
					isFormValid = false;
					break;
				}
				isFormValid = true;
			}

			if (!isFormValid) {
				e.preventDefault();
			} else {
				var form_data = {
					name : $("#name-reg").val(),
					email : $("#email-reg").val(),
					password : $("#password-reg").val(),
					ktalk : $("#ktalk-reg").val(),
					phone : $("#phone-reg").val(),
					birthday : $("#birthday-reg").val(),
					bio : $("#bio-reg").val(),
					is_ajax : 1
				};

				$.ajax({
					type : "POST",
					url : "join",
					data : form_data,
					success : function(text) {
						response = text;
						$("#name-reg").val('');
						$("#email-reg").val('');
						$("#password-reg").val('');
						$("#conf-password-reg").val('');
						$("#ktalk-reg").val('');
						$("#phone-reg").val('');
						$("#birthday-reg").val('');
						$("#bio-reg").val('');

						if (response == 'Success') {
							modal.close();
						} else {
							$("#message-reg").html("<p style='color:white'> 입력하신 정보가 이미 서버에 있어 회원가입이 거부되었습니다.</p>");
							event.preventDefault();
						}
					},
					fail : function() {
						showErrorMessage(document.getElementById('message-reg'));
						$("#message").html("<p style='color:white'>서버에 이상이 있어 데이터를 업데이트 하지 못했습니다.</p>");
						event.preventDefault();
					}
				});
			}
		});

		// 이벤트 등록 함수
		//
		function addEvent(el, event, callback) {
			if ('addEventListener' in el) {
				el.addEventListener(event, callback, false);
			} else {
				el['e' + event + callback] = callback;
				el[event + callback] = function() {
					el['e' + event + callback](window.event);
				};

				el.attachEvent('on' + event, el[event + callback]);
			}
		}

		// 비번 보이기 > input 타입을 변경함.
		//
		(function() {

			var pwd = document.getElementById('pwd');
			var chk = document.getElementById('showPwd');

			addEvent(chk, 'change', function(e) {
				var target = e.target || e.srcElement;
				try {
					if (target.checked) {
						pwd.type = 'text';
					} else {
						pwd.type = 'password';
					}
				} catch (error) {
					alert('This browser cannot switch type');
				}
			});
		}());

		// Place Holder 셋팅
		//
		(function() {
			if ('placeholder' in document.createElement('input')) {
				return;
			}

			var length = document.forms.length;
			for (var i = 0, l = length; i < l; i++) {
				showPlaceholder(document.forms[i].elements);
			}

			function showPlaceholder(elements) {
				for (var i = 0, l = elements.length; i < l; i++) {
					var el = elements[i];

					if (!el.placeholder) {
						continue;
					}

					el.style.color = '#666666';
					el.value = el.placeholder;

					addEvent(el, 'focus', function() {
						if (this.value === this.placeholder) {
							this.value = '';
							this.style.color = '#000000';
						}
					});

					addEvent(el, 'blur', function() {
						if (this.value === '') {
							this.value = this.placeholder;
							this.style.color = '#666666';
						}
					});
				}
			}
		}());

		//패스워드 더블 체크
		//
		(function() {
			var password = document.getElementById('password-reg');
			var passwordConfirm = document.getElementById('conf-password-reg');

			function setErrorHighlighter(e) {
				var target = e.target || e.srcElement;
				if (target.value.length < 8) {
					target.className = 'fail';
				} else {
					target.className = 'pass';
				}
			}

			function removeErrorHighlighter(e) {
				var target = e.target || e.srcElement;
				if (target.className === 'fail') {
					target.className = '';
				}
			}

			function passwordsMatch(e) {
				var target = e.target || e.srcElement;

				if ((password.value === target.value) && target.value.length >= 8) {
					target.className = 'pass';
				} else {
					target.className = 'fail';
				}
			}

			addEvent(password, 'focus', removeErrorHighlighter);
			addEvent(password, 'blur', setErrorHighlighter);
			addEvent(passwordConfirm, 'focus', removeErrorHighlighter);
			addEvent(passwordConfirm, 'blur', passwordsMatch);
		}());

		var validateType = {
			email : function(el) {
				var valid = /[^@]+@[^@]+/.test(el.value);
				if (!valid) {
					setErrorMessage(el, '유효한 email 을 입력하세요.');
				}
				return valid;
			},
			number : function(el) {
				var valid = /^\d+$/.test(el.value);
				if (!valid) {
					setErrorMessage(el, '유효한 휴대폰 번호를 입력하세요.');
				}
				return valid;
			},
			date : function(el) {
				var valid = /^(\d{2}\/\d{2}\/\d{4})|(\d{4}-\d{2}-\d{2})$/.test(el.value);
				if (!valid) {
					setErrorMessage(el, '유효한 날짜를 입력하세요.');
				}
				return valid;
			}
		};

	}());

	// Modal Popup 객체
	//
	var modal = (function() {

		var $window = $(window);
		var $modal = $('<div class="modal"/>');
		var $content = $('<div class="modal-content"/>');
		var $cancel = $('#cancel');
		var $cancelReg = $('#cancelReg');

		$modal.append($content);

		$cancel.on('click', function(e) {
			e.preventDefault();
			modal.close();
			location.reload();
		});

		$cancelReg.on('click', function(e) {
			e.preventDefault();
			modal.close();
			location.reload();
		});

		return {
			center : function() { //위치를 center로 옮김
				var top = Math.max($window.height() - $modal.outerHeight(), 0) / 2;
				var left = Math.max($window.width() - $modal.outerWidth(), 0) / 2;

				$modal.css({
					top : top + $window.scrollTop(),
					left : left + $window.scrollLeft()
				});
			},

			open : function(settings) {
				$content.empty().append(settings.content);

				$modal.appendTo('body');

				modal.center(); // Call center() method
				$(window).on('resize', modal.center);
			},

			close : function() {
				$content.empty();
				$modal.detach();
				$(window).off('resize', modal.center); // Remove event handler
			}
		};
	}());

	// modal open
	//
	(function() {
		var $contentLogin = $('#login-options').detach();
		var $contentRegister = $('#register_options').detach();

		$('#loginDiv').on('click', function() {
			modal.close();
			modal.open({
				content : $contentLogin
			});
		});

		$('#registerUserDiv').on('click', function() {
			modal.close();
			modal.open({
				content : $contentRegister
			});
		});
	}());

});
