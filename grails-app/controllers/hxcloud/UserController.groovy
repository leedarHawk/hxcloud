package hxcloud

import grails.converters.JSON
import grails.transaction.Transactional

class UserController {

    def userService
    def mailService
    def grailsApplication

    def index() {
        def userList = User.list()
        render view:'index', model: [userList: userList]
    }

    def create(){
        render view:'create'
    }

    @Transactional
    def save(User user){
        userService.serviceMethod()
        println User.list()
        println user.mobile
        user.username = "aaa"
        user.save(flush: true)
        render view:'create'
    }

    def testJson(){
        def json = request.JSON
        println json
        def user = new User(mobile:"123129874")

        def rtn = [name: "hawk", pass: "zzz"]
        rtn.user =  user

        render rtn as JSON
    }


    def update(User user){
        user.username = "zzz"
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
}
