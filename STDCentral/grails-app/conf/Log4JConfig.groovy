// log4j configuration
def catalinaBase = System.properties.getProperty('catalina.base')
if (!catalinaBase) catalinaBase = '.'   // just in case
String rootLocation = "${catalinaBase}/logs"
String appName="stdc"

println "************** LOADING LOG4J CONFIG ********************"
println "Logging directory : ${rootLocation}/"
log4j = {

    // Example of changing the log pattern for the default console
    // appender:
    //
    // appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '[%-7p][%d{dd/MM/yyyy HH:mm:ss,SSS}] %C %m%n')
    // }

    appenders {
        rollingFile name : 'debugAppender',
                    maxFileSize : "10MB",
                    maxBackupIndex : 1,
                    append : true,
                    threshold: DEBUG,
                    file : "${rootLocation}/${appName}_debug.log".toString()

        rollingFile name : 'infoAppender',
                    maxFileSize : "10MB",
                    maxBackupIndex : 1,
                    threshold: INFO,
                    append : true,
                    file : "${rootLocation}/${appName}_info.log".toString()

        rollingFile name : 'warnAppender',
                    maxFileSize : "10MB",
                    maxBackupIndex : 1,
                    threshold: WARN,
                    append : true,
                    file : "${rootLocation}/${appName}_warn.log".toString()

        rollingFile name : 'errorAppender',
                    maxFileSize : "10MB",
                    maxBackupIndex : 1,
                    threshold: ERROR,
                    append : true,
                    file : "${rootLocation}/${appName}_error.log".toString()

        console     name : "stdout",
                    threshold: ERROR
    }

    root {
      error 'errorAppender', additivity:false
      warn  'warnAppender', additivity:false
      info  'infoAppender', additivity:false
      debug 'debugAppender', additivity:false
      layout: pattern(conversionPattern: "%c %d{ISO8601} -- %p -- %m%n")
    }

    // warn  warnAppender: 'org.codehaus.groovy.grails.web.servlet'  //  controllers
    // warn  warnAppender: 'org.codehaus.groovy.grails.web.pages' //  GSP
    // warn  warnAppender: 'org.codehaus.groovy.grails.web.mapping.filter' // URL mapping

    // warn  warnAppender: 'org.codehaus.groovy.grails.web.sitemesh' //  layouts
    // warn  warnAppender: 'org.codehaus.groovy.grails.web.mapping' // URL mapping
    // warn  warnAppender: 'org.codehaus.groovy.grails.commons' // core / classloading
    // warn  warnAppender: 'org.codehaus.groovy.grails.plugins' // plugins
    // warn  warnAppender: 'org.codehaus.groovy.grails.orm.hibernate' // hibernate
    // warn  warnAppender: 'org.springframework'
    // warn  warnAppender: 'org.hibernate'
    // warn  warnAppender: 'net.sf.ehcache.hibernate'
}

println '************** END LOG4J CONFIG ********************'

