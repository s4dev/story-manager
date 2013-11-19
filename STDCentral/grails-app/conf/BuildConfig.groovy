import grails.util.Environment
import groovy.xml.DOMBuilder
import groovy.xml.XmlUtil
import groovy.xml.dom.DOMCategory

grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins
        grailsPlugins()
        grailsHome()
        grailsCentral()
        mavenCentral()

        // uncomment these to enable remote dependency resolution from public Maven repositories
        //mavenCentral()
        //mavenLocal()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        // don't include mysql jar in prod (provided by environment)
        //if ( Environment.current != Environment.PRODUCTION ) {
            runtime 'mysql:mysql-connector-java:5.1.16'
        //}
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.7.1"
        runtime ":jquery-ui:1.8.11"
        runtime ":resources:1.1.6"

        runtime ":database-migration:1.1"

        // Uncomment these (or add new ones) to enable additional resources capabilities
        //runtime ":zipped-resources:1.0"
        //runtime ":cached-resources:1.0"
        //runtime ":yui-minify-resources:0.1.4"

        build ":tomcat:$grailsVersion"

        compile ":rendering:0.4.3"
        compile ":console:1.1"
        compile ":cache:1.0.0"
        test ":spock:0.7"

        runtime ":spring-security-core:1.2.7.3"

    }
}

// grails.war.resources = { stagingDir, args ->
//     // Now update the web xml
//     addSecurityConfig("${stagingDir}/WEB-INF/web.xml")
// }

// //add security config to web.xml to secure app
// private def addSecurityConfig(webXmlPath) {
//     def webXmlFile = new File(webXmlPath)
//     def wxml = DOMBuilder.parse(new StringReader(webXmlFile.text)).documentElement

//     use (DOMCategory) {
//         def secNode = wxml.appendNode "security-constraint", [:]
//         def webResNode = secNode.appendNode "web-resource-collection", [:]
//         webResNode.appendNode "web-resource-name", "STDC"
//         webResNode.appendNode "url-pattern", '/*'
//         def authNode = secNode.appendNode 'auth-constraint', [:]
//         authNode.appendNode 'role-name', 'stdc-gui'

//         def loginNode = wxml.appendNode 'login-config', [:]
//         loginNode.appendNode 'auth-method', 'BASIC'
//         loginNode.appendNode 'realm-name', 'stdcrealm'

//     }
//     println XmlUtil.serialize(wxml)
//     webXmlFile.withWriter { it << XmlUtil.serialize(wxml) }

// }