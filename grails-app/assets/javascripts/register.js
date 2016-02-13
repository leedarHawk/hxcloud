(function($){
	var _initPStrength = function(){
		$.module.pstrength.create('#fm-regist-mobile-password');
		$.module.pstrength.create('#fm-regist-email-password');
	}
	var _initValidator = function(){
	 
		$.module.validator.add('#fm-regist-id-email', [
			'noempty',
			'vamail',
			{
				exec:'length',
				args:[6,35],
				error:function(){return $.i18n.prop("register.class.notValidEmail");}
			},
			 
			{
			  exec:function(){
			     $.ajax({
				    url : 'check.action',
				    type: "POST",
				    async:false,
				    dataType:"json",
				    data : {"logName":$.trim($(this).val()),"type":"email"},
				    success: function(data){
				      flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return $.i18n.prop("register.class.emailExisted");}
			}
		]);
		 $.module.validator.add('#fm-regist-mobile-id-userName', [
			'noempty',
			{exec:'length',args:[1,50]},
			{
			  exec:function(){
				 var re = /^[\u4e00-\u9fa5a-zA-Z0-9@_.]+$/gi;
			     return re.test(this.val());
			  },
			  error:function(){return '姓名包含特殊字符';}
			}
			/*{
			  exec:function(){
			     $.ajax({
				    url : 'register/check.action?action=logName',
				    async:false,
				    dataType:"json",
				    data : {"logName":$.trim($(this).val())},
				    success: function(data){
				         flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return '用户名已存在';}
			}*/
		]);
		
		$.module.validator.add('#fm-regist-mobile-password', [
		 {
				exec:function(){
					return this.val()!="";
				},
				error:$.i18n.prop("register.class.notNull")
			},
			{exec:'length',args:[6,20],error:$.i18n.prop("register.class.pwdLimit3")},
			{
				exec:function(){
					return !(/\s/g.test(this.val()));
				},
				error:$.i18n.prop("register.class.pwdLimit3")
			},
			{
				exec:function(){
					var _result = 0,
						_value = this.val();
					/\d/g.test(_value) && _result++;
					/[a-z]/g.test(_value) && _result++;
					/[A-Z]/g.test(_value) && _result++;
					/[\W|_]/g.test(_value) && _result++;
					return _result >= 2;
				},
				error:$.i18n.prop("register.class.pwdLimit3")
			},
			{
				exec:function(){
					return $.module.pstrength.checkPassword(this) > 0;
				},
				error:function(){
					var nPerc = $.module.pstrength.checkPassword(this);
					return $.module.pstrength.getErrormsg(nPerc);
				}
			}
		]);
		
		$.module.validator.add('#fm-regist-mobile-repassword', [
			{
				exec:function(){
					return this.val()!="";
				},
				error:$.i18n.prop("register.class.notNull")
			},
			{
				exec:function(){return this.val() === $('#fm-regist-mobile-password').val();},
				error:$.i18n.prop("register.class.pwdInconformity")
			}
		]);
		
		$.module.validator.add('#fm-regist-email-id-userName', [
			'noempty',
			{exec:'length',args:[1,50]},
			{
				  exec:function(){
					 var re = /^[\u4e00-\u9fa5a-zA-Z0-9@_.]+$/gi;
				     return re.test(this.val());
				  },
				  error:function(){return '姓名包含特殊字符';}
				}
			/*{
			  exec:function(){
			     $.ajax({
				    url : 'register/check.action?action=logName',
				    async:false,
				    dataType:"json",
				    data : {"logName":$.trim($(this).val())},
				    success: function(data){
				         flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return '用户名已存在';}
			}*/
		]);

        $.module.validator.add('#fm-regist-email-password', [
            {
				exec:function(){
					return this.val()!="";
				},
				error:$.i18n.prop("register.class.notNull")
			},
			{exec:'length',args:[6,20],error:$.i18n.prop("register.class.pwdLimit3")},
			{
				exec:function(){
					return !(/\s/g.test(this.val()));
				},
				error:$.i18n.prop("register.class.pwdLimit3")
			},
			{
				exec:function(){
					var _result = 0,
						_value = this.val();
					/\d/g.test(_value) && _result++;
					/[a-z]/g.test(_value) && _result++;
					/[A-Z]/g.test(_value) && _result++;
					/[\W|_]/g.test(_value) && _result++;
					return _result >= 2;
				},
				error:$.i18n.prop("register.class.pwdLimit3")
			},
			{
				exec:function(){
					return $.module.pstrength.checkPassword(this) > 0;
				},
				error:function(){
					var nPerc = $.module.pstrength.checkPassword(this);
					return $.module.pstrength.getErrormsg(nPerc);
				}
			}
		]);


        $.module.validator.add('#fm-regist-email-repassword', [
			{
				exec:function(){
					return this.val()!="";
				},
				error:$.i18n.prop("register.class.notNull")
			},
			{
				exec:function(){return this.val() === $('#fm-regist-email-password').val();},
				error:$.i18n.prop("register.class.pwdInconformity")
			}
		]);
		
		$.module.validator.add('#J-mobile-checkcode', [
            'noempty',
            {
			  exec:function(){
			     $.ajax({
				    url : 'checkCode.action',
				    type:"POST",
				    async:false,
				    dataType:"json",
				    data : {"code":$.trim($(this).val())},
				    success: function(data){
				        flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return $.i18n.prop("register.class.verifyCodeError");}
			}
        ]);
        
        $.module.validator.add('#J-email-checkcode', [
            'noempty',
            {
			  exec:function(){
			     $.ajax({
				    url : 'checkCode.action',
				    type:"POST",
				    async:false,
				    dataType:"json",
				    data : {"code":$.trim($(this).val())},
				    success: function(data){
				        flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return $.i18n.prop("register.class.verifyCodeError");}
			}
        ]);
	}
	var _initRegister = function(){
		$.module.smssender.add('#fm-regist-sendsms', '#fm-regist-mobile');
		$.module.validator.add('#fm-regist-mobile', [
			'noempty',
			'numberonly',
			'vamobile',
			{
			  exec:function(){
			     $.ajax({
				    url : 'check.action',
				    type:"POST",
				    async:false,
				    dataType:"json",
				    data : {"logName":$.trim($(this).val()),"type":"mobile"},
				    success: function(data){
				      flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return $.i18n.prop("register.class.mobileExisted");}
			}
		]);
		$.module.validator.add('#fm-regist-checkcode', [
			'noempty',
			'numberonly',
			{
				exec:'length',
				args:[6,6]
			},
			{
			  exec:function(){
			     $.ajax({
				    url : 'checkMobileCode.action',
				    type:"POST",
				    async:false,
				    dataType:"json",
				    data : {"mobile":$.trim($("#fm-regist-mobile").val()),"code":$.trim($(this).val())},
				    success: function(data){
				      flag=data.msg;
				    }
			     });
			     return flag;
			  },
			  error:function(){return $.i18n.prop("verify.class.unactive");}
			}
		]);
		 
		$.module.validator.add('#fm-regist-email-checkcode', [
			'noempty',
			'numberonly',
			{
				exec:'length',
				args:[4,4]
			}
		]);
	}
	$(function(){
		_initPStrength();
		_initValidator();
		_initRegister();
		$('#userProtocol').click(function(){
		    if($(this).is(":checked")==true){
		     $('#fm-regist-mobile-submit').attr("disabled",false);
		    }else if($(this).is(":checked")==false){
		     $('#fm-regist-mobile-submit').attr("disabled",true);
		    }
		});
		$('#emailProtocol').click(function(){
		    if($(this).is(":checked")==true){
		     $('#fm-regist-email-submit').attr("disabled",false);
		    }else if($(this).is(":checked")==false){
		     $('#fm-regist-email-submit').attr("disabled",true);
		    }
		});
		 
		
		$('#regist-mobile').on('submit', function(ev){
			if($('#regist-mobile .fm-haserror').length){
				ev.preventDefault();
				return false;
			}
			if(!$.module.validator.validateAll('#regist-mobile')){
				ev.preventDefault();
				return false;
			}
			if(!confirm($.i18n.prop("register.class.confirmRegister"))){
                return false;
            }
    
            jQuery('#fm-regist-mobile-submit').val($.i18n.prop("register.class.registering"));
            jQuery('#fm-regist-mobile-submit').attr("disabled","disabled");
			return true;
		});
		
		$('#regist-email').on('submit', function(ev){
			if($('#regist-email .fm-haserror').length){
				ev.preventDefault();
				return false;
			}
			if(!$.module.validator.validateAll('#regist-email')){
				ev.preventDefault();
				return false;
			}
			if(!confirm($.i18n.prop("register.class.confirmRegister"))){
                return false;
            }
    
            jQuery('#fm-regist-email-submit').val($.i18n.prop("register.class.registering"));
            jQuery('#fm-regist-email-submit').attr("disabled","disabled");
			return true;
		});
	});
})(jQuery);
