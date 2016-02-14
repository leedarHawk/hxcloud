package hxcloud

import grails.transaction.Transactional
import com.huaxincloud.platform.utils.MD5Util
import com.huaxincloud.platform.utils.DESPlus

@Transactional
class UserService {

    def mailService

    def boolean processRegister(User user, String url, String mode) {
        boolean flag = false
        String logName = user.logName
        if(logName.isEmpty()) {
            return flag
        }
        def c = User.createCriteria()
        def resCount = c.count {
            and {
                eq("logName", logName)
            }
        }
        if(resCount > 0) {
            return flag
        }
        user.createTime = new Date()
        user.userResource = "Register"
        user.validateStatus = 0
        user.custId = 123456
        user.userPwd = MD5Util.encode2hex(user.userPwd == null ? "" : user.userPwd)

        // 手机注册
        if(mode.equals("1")) {
            user.mobile = user.logName
            user.validateCode = user.mobile
            user.mobileStatus = 1
            user.status = "2" //激活
            user.validateStatus = "1"
        }
        // 邮箱注册
        else if(mode.equals("2")) {
            user.status = "1" //未激活
            user.email = user.logName
            user.emailStatus = 1
            user.validateCode = MD5Util.encode2hex(user.email)
        }
        user.save(flush : true)
        sendEmail(url, user.email)
        return true
    }

    def String processActivate(String email, String validateCode) {
        def c = User.createCriteria()
        List result = c.list {
            and {
                eq("logName", email)
                eq("email", email)
            }
        }
        if(result.size() == 1) {
            User user = (User)result.get(0)
            // 验证用户激活状态 -- // 没激活
            if (user.validateStatus == 0) {
                Calendar cl = Calendar.getInstance();
                cl.setTime(user.createTime);
                cl.add(Calendar.DATE, 1);
                // 验证链接是否过期
                if (new Date().before(cl.getTime())) {
                    if (validateCode.equals(user.validateCode)) {
                        user.validateStatus = 1
                        user.status = "2"
                        user.save(flush : true)
                        return user.logName
                    }
                    else {
                        throw new Exception("verifyCodeError")
                    }
                }
                else {
                    throw new Exception("verifyCodeOverdue")
                }
            }
            else {
                throw new Exception("emailActivated")
            }
        }
        else {
            throw new Exception("emailUnRegister")
        }
    }

    def processLogin() {

    }

    def sendEmail(String url, String email) {
        // /邮件的内容
        DESPlus ds = new DESPlus();
        String changeemail = ds.encrypt(email);
        url = url + "&email=" + changeemail + "&validateCode=" + MD5Util.encode2hex(email);

        StringBuffer sb = new StringBuffer("请点击下面的链接来激活帐户");
        sb.append("<a href=\"").append(url).append("\">").append(url).append("</a>")
        try{
            mailService.sendMail{to email
                from "275691475@qq.com"
                subject "Testing Activation"
                body sb.toString() }
        }catch(Exception e){
            log.error(e)
        }
    }
}