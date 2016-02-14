package hxcloud

import grails.converters.JSON
import grails.transaction.Transactional
import redis.clients.jedis.Jedis
import com.huaxincloud.platform.utils.RandomUtil
import com.huaxincloud.platform.utils.DESPlus
import com.huaxincloud.platform.utils.MD5Util

class UserController {

    def userService
    def mailService
    def grailsApplication
    def redisService

    def index() {
        def userList = User.list()
        render view:'index', model: [userList: userList]
    }

    def create(){
        render view:'create'
    }

    @Transactional
    def save(User user){
        //userService.serviceMethod()
        //println User.list()
        println user.mobile
        //user.userName = "aaa"
        //user.save(flush: true)
        render view:'create'
    }

    def testJson(){
        def json = request.JSON
        println json
        def user = new User(mobile:"123129874")

        def rtn = [name: "hawk", pass: "zzz"]
        rtn.user =  user

        redisService.withRedis{ Jedis redis ->


        }

        render rtn as JSON
    }


    def update(User user){
        user.userName = "zzz"
        user.save()
        render view:"index"
    }

    def sendMail(User user) {
        grailsApplication.config.grails.conf
        def from ="hawk.wan@139.com"
        try{
            mailService.sendMail{to
                from "275691475@qq.com"
                subject "Hello Kevin"
                body 'How are you?' }
        }catch(Exception e){
            log.error(e)
        }

        render view:'create'
    }

    /**
     * 注册
     * @return
     */
    def register() {
        render view:'register'
    }

    /**
     * 登录名查重
     * @return
     */
    def check() {
        def rtn = null
        def logName = request.getParameter('logName')
        def c = User.createCriteria()
        def resCount = c.count {
            and {
                eq("logName", logName)
            }
        }
        if(resCount > 0) {
            rtn = ["msg" : false]
        }
        else {
            rtn = ["msg" : true]
        }
        render rtn as JSON
    }

    /**
     * 检查校验码
     * @return
     */
    def checkCode() {
        def rtn = null
        def code = request.getParameter("code");
        if(code.equalsIgnoreCase(session.getAttribute("code"))) {
            rtn = ["msg" : true]
        }
        else {
            rtn = ["msg" : false]
        }
        render rtn as JSON
    }

    /**
     * 手机下行发送验证码
     */
    def sendVerifyCode() {
        String verifyCode = RandomUtil.createRandom(true, 6);
        String mobile = request.getParameter("mobile");
    }

    /**
     * 校验手机验证码
     */
    def checkMobileCode() {

    }

    /**
     * 邮箱注册
     * @param user
     * @return
     */
    def emailRegister(User user) {
        println user.logName
        String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()
        String url = path + "/user/activate"
        userService.processRegister(user, url, "2")
    }

    /**
     * 手机注册
     * @param user
     * @return
     */
    def mobileRegister(User user) {
        println user.logName
        String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()
        String url = path + "/user/activate"
        userService.processRegister(user, url, "1")
    }

    /**
     * 登录
     */
    def login() {
        String name = request.getParameter("userName")
        String loginPassword = request.getParameter("loginPassword")
        String veriticationCode = request.getParameter("veriticationCode")
        String code = (String)request.getSession().getAttribute("code")

        request.setAttribute("name", name)
        if(!code.equalsIgnoreCase(veriticationCode)) {
            render view : "error", model: ["error" : "验证码不正确！"]
            return
        }
        def c = User.createCriteria()
        List result = c.list {
            and {
                eq("logName", name)
            }
        }
        User loginUser = null
        if(result.size() == 1) {
            loginUser = result.get(0)
        }
        if (null == loginUser) {
            //request.setAttribute("error", "该用户不存在")
            render view : "error", model: ["error" : "该用户不存在"]
            return
        }

        if (!loginUser.userPwd.equals(MD5Util.encode2hex(loginPassword))) {
            //request.setAttribute("error", "密码错误")
            render view : "error", model: ["error" : "密码错误"]
            return
        }
        /**
         * 1 未激活/未验证资料 2 正常 3 冻结 4 停用
         */
        if ("1".equals(loginUser.status) || loginUser.status == null)
        {
            if (!"1".equals(loginUser.validateCode) && loginUser.logName.indexOf("@") > 0)
            {
                //request.setAttribute("error", "reactive")
                //request.setAttribute("email", loginUser.logName)

                render view : "error", model: ["error" : "reactive", "email" : loginUser.logName]
                return
            }
            else
            {
                //request.setAttribute("error", "账号未激活/未验证资料")
                render view : "error", model: ["error" : "账号未激活/未验证资料"]
                return
            }

        }

        if ("3".equals(loginUser.status))
        {
            //request.setAttribute("error", "账号已冻结!")
            render view : "error", model: ["error" : "账号已冻结!"]
            return

        }

        if ("4".equals(loginUser.status))
        {
            //request.setAttribute("error", "账号已停用!")
            render view : "error", model: ["error" : "账号已停用!"]
            return
        }

        render view : "create"
    }

    def toLogin() {
        render view : "login"
    }

    /**
     * 激活
     */
    def activate() {
        //激活
        String type = request.getParameter("type")
        DESPlus ds = new DESPlus()
        String email = request.getParameter("email") //获取email
        email = ds.decrypt(email)
        String validateCode = request.getParameter("validateCode") //激活码

        try {
            String registerName = userService.processActivate(email, validateCode)
            request.setAttribute("registerName", registerName)
        } catch (Exception e) {
            request.setAttribute("MessageInfo", e.getMessage())
            request.setAttribute("MessageUrl", "../register/index.action")
            render view : 'showmessage'
        }
        if("reactive".equals(type)){
            render view : "reactive"
        }else{
            render view : "activate"
        }
    }

    /**
     * 找回密码
     */
    def findPwd() {

    }

    def toFindPwd() {
        render view : "findPwd"
    }

    def findUser() {
        String name = request.getParameter("logName");
        String vcode = request.getParameter("verifyCode");
        String veriticationCode = (String)request.getSession().getAttribute("code");

        if(!vcode.equalsIgnoreCase(veriticationCode)) {
            render view : "error", model: ["error" : "验证码不正确！"]
            return
        }

        def c = User.createCriteria()
        List result = c.list {
            and {
                eq("logName", name)
            }
        }
        User user = null
        if(result.size() == 1) {
            user = result.get(0)
        }
        if (null == user) {
            //request.setAttribute("error", "该用户不存在")
            render view : "error", model: ["error" : "该用户不存在"]
            return
        }
        String email = null
        if(!user.email.isEmpty() && user.email.split("@").length > 1) {
            String prefix = user.email.split("@")[0];
            if (prefix.length() < 4)
            {
                prefix += "****"
            }
            email = prefix.substring(0, prefix.length() - 4)
            + prefix.substring(prefix.length() - 4).replaceAll("\\S{4}", "****")
            + user.getEmail().substring(prefix.length())
        }

        String mobile = null
        if (!user.mobile.isEmpty() && user.mobile.length() > 7)
        {
            mobile = user.mobile
            mobile =
                    mobile.substring(0, 3) + mobile.substring(3, 7).replaceAll("\\d{4}", "****") + mobile.substring(7)
        }

        render view : 'findPwd2', model: ["email" : email, "mobile" : mobile, "user" : user]
    }

    /**
     * 更新个人信息
     */
    def updateInfo() {

    }

    def reactive() {
        String logName = request.getParameter("reemail");
        def c = User.createCriteria()
        List result = c.list {
            and {
                eq("logName", logName)
            }
        }
        User user = null
        if(result.size() == 1) {
            user = result.get(0)
        }
        if(user != null) {
            user.createTime = new Date()
            user.save(flush : true)
        }
        render view : 'Successful'
    }

    /**
     * 重发激活邮件
     */
    def resendEmail() {
        String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()
        String url = path + "/user/activate"
        String email = request.getParameter("email")
        String type = request.getParameter("type")
        if("reactive".equals(type)){
            url = url + "&type=reactive"
        }
        userService.sendEmail(url, email)
    }
}
