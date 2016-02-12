package hxcloud

import grails.transaction.Transactional

class UserController {

    def userService

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

    def update(User user){
        user.username = "zzz"
        user.save()
        render view:"index"
    }
}
