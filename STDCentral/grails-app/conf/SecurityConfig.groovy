
println "************** LOADING SECURITY CONFIG ********************"

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'std.security.Person'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'std.security.PersonRole'
grails.plugins.springsecurity.authority.className = 'std.security.Role'

grails.plugins.springsecurity.rejectIfNoRule = false

grails.plugins.springsecurity.securityConfigType = 'InterceptUrlMap'

// new Requestmap(url: '/js/**',     configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/css/**',    configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/images/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/login/**',  configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/logout/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/home/**',   configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
// new Requestmap(url: '/**',        configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()

grails.plugins.springsecurity.interceptUrlMap = [
   '/js/**':        ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/css/**':       ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/images/**':    ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/login/**':     ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/logout/**':    ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/home/**':    ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/**':    ['ROLE_STDC']
]

println "Security Map: ${grails.plugins.springsecurity.interceptUrlMap}"

println '************** END SECURITY CONFIG ********************'