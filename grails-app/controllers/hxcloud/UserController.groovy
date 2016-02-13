package hxcloud

import grails.converters.JSON
import grails.transaction.Transactional
import redis.clients.jedis.Jedis
import com.huaxincloud.platform.utils.RandomUtil

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

    def register() {
        render view:'register'
    }

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

    def sendVerifyCode() {
        def verifyCode = RandomUtil.createRandom(true, 6);
        def mobile = request.getParameter("mobile");
    }

    /**
     * 检验手机验证码
     */
    def checkMobileCode() {

    }

    def emailRegister(User user) {
        println user.logName
    }

    def mobileRegister(User user) {
        println user.logName
    }
}
