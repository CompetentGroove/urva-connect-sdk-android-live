package kz.team.library.model

class UrvaConnectConfig {

    var domain: String = ""
    var orgCode: String? = null
    var username: String? = null
    var companyToken: String? = null
    var fcmToken: String? = ""
    var first_name: String? = null
    var last_name: String? = null

    constructor(orgCode: String?, username: String?, companyToken: String?,first_name: String?, last_name: String? ) {
        this.orgCode = orgCode
        this.username = username
        this.companyToken = companyToken
        this.first_name =first_name
        this.last_name=last_name
    }
}