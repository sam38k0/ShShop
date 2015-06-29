
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

//////////////////////////////////////////////////////////////////////////////////////////

(function() {
	  var options = {};
	  options[0]  = document.getElementById('connection1');                  
	  options[1]  = document.getElementById('connection2');        
	  options[2]  = document.getElementById('connection3');                  
	  options[3]  = document.getElementById('connection4');  
	  options[4]  = document.getElementById('connection5');        
	  options[5]  = document.getElementById('connection6');                  
	  options[6]  = document.getElementById('connection7');    
	  var all      = document.getElementById('all');

	  function updateAll() {
	    for (var i = 0; i < 7; i++) {
	      options[i].checked = all.checked;
	    }
	  }
	  addEvent(all, 'change', updateAll);

	  function clearAllOption(e) {
	    var target = e.target || e.srcElement;
	    if (!target.checked) {
	      all.checked = false;
	    }
	  }
	  for (var i = 0; i < 7; i++) {         
	    addEvent(options[i], 'change', clearAllOption);
	  }

	}());

$(document).ready(function() {

	(function() {
		document.forms.insertProductForm.noValidate = true;
		
		$('#insertProductForm').on('submit', function(e) {
			var elements = this.elements;
			var valid = {};
			var isValid;
			var isFormValid;
			var validateProductType = {
				number : function(el) {
					var valid = /^\d+$/.test(el.value);
					if (!valid) {
						setErrorMessage(el, '유효한 수를 입력하세요.');
					}
					return valid;
				}
			};

			var i;
			for (i = 0, l = elements.length; i < l; i++) {

				isValid = validateRequired(elements[i]) && validateProductType(elements[i]);
				if (!isValid) {
					showErrorMessage(elements[i]);
				} else {
					removeErrorMessage(elements[i]);
				}
				valid[elements[i].id] = isValid;
			}

			for ( var field in valid) {
				if (!valid[field]) {
					isFormValid = false;
					break;
				}
				isFormValid = true;
			}

			if (!isFormValid)
				e.preventDefault();
		});

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
	}());


	var categoryResultElem = document.getElementById('categoryResult');
	var subFileElem1 = document.getElementById('subfile1');
	var subFileElem2 = document.getElementById('subfile2');
	var subFileElem3 = document.getElementById('subfile3');
	var subFileElem4 = document.getElementById('subfile4');
	var subFileElem5 = document.getElementById('subfile5');

	categoryResultElem.readOnly = true;
	subFileElem1.readOnly = true;
	subFileElem2.readOnly = true;
	subFileElem3.readOnly = true;
	subFileElem4.readOnly = true;
	subFileElem5.readOnly = true;

	function reviewUploadImg(fileId) {
		var fileObj = document.getElementById(fileId);
		var filePath = fileObj.value;
		var fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
		var fileKind = fileName.split(".")[1];
		if (fileKind == "jpg" || fileKind == "gif" || fileKind == "png")
			return true;

		alert("jpg, gif, png 확장자를 가진 이미지 파일만 올려주세요.");
		return false;
	}

	// File Upload Control
	$('#fileId1').change(function() {
		if (reviewUploadImg('fileId1')) {
			subFileElem1.readOnly = false;
			$('#subfile1').val($(this).val());
			subFileElem1.readOnly = true;
		}
	});

	$('#fileId2').change(function() {
		if (reviewUploadImg('fileId2')) {
			subFileElem2.readOnly = false;
			$('#subfile2').val($(this).val());
			subFileElem2.readOnly = true;
		}
	});

	$('#fileId3').change(function() {
		if (reviewUploadImg('fileId3')) {
			subFileElem3.readOnly = false;
			$('#subfile3').val($(this).val());
			subFileElem3.readOnly = true;
		}
	});

	$('#fileId4').change(function() {
		if (reviewUploadImg('fileId4')) {
			subFileElem4.readOnly = false;
			$('#subfile4').val($(this).val());
			subFileElem4.readOnly = true;
		}
	});

	$('#fileId5').change(function() {
		if (reviewUploadImg('fileId5')) {
			subFileElem5.readOnly = false;
			$('#subfile5').val($(this).val());
			subFileElem5.readOnly = true;
		}
	});

	// Category Control
	var i = 0, result = "";
	$('#insertProduct_category a').click(function() {
		i = 0;
		result = '';
		$(this).parentsUntil('#insertProduct_category>ul>li>ul').each(function(index) {
			if (this.tagName === 'LI' && i === 0) {
				result = $(this).children('A').text();
				i++;
			} else if (this.tagName === 'LI') {
				result = $(this).children('A').text() + " > " + result;
			}
		});

		categoryResultElem.readOnly = false;
		$('#categoryResult').val(result);
		categoryResultElem.readOnly = true;
	});
	
});
