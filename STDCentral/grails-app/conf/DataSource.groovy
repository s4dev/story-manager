import org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsAnnotationConfiguration

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}

//default datasource settings
dataSource {
	if (System.getProperty("dbCreate")) {
	    dbCreate =  "create"
	} else if (System.getProperty("dbDrop")) {
	    dbCreate = "create-drop"
	} else if (System.getProperty("dbUpdate")) {
	    dbCreate = "update"
	} else if (System.getProperty("dbNone")) {
		dbCreate = "none"
	} else {
        dbCreate = "validate"
    }
    println "Datasource set to: $dbCreate"
    if (System.getProperty("logSql")) {
        logSql = true
    } else {
        logSql = false
    }
    if (logSql)
        println "logSql set to: true"
    else
        println "logSql set to false"
}

// environment specific settings
environments {
    development {
        if (System.getProperty('dbMemory')) {
            dataSource {
                driverClassName = "org.h2.Driver"
                //override the default to create-drop
                dbCreate = "create-drop"
                username = "sa"
                password = ""
                url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            }
        } else {
    	    println "****Connecting to Local MySQL DB****"
    	    dataSource {
                pooled = true
    	        configClass = GrailsAnnotationConfiguration.class
                zeroDateTimeBehavior="convertToNull" //Java can't convert ''0000-00-00 00:00:00' to TIMESTAMP
                driverClassName = "com.mysql.jdbc.Driver"
                username = "grails"
                password = "server"
                url = "jdbc:mysql://localhost/stdc_dev"
                dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            }
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            dbCreate = "validate"
            logSql = false
            configClass = GrailsAnnotationConfiguration.class
            zeroDateTimeBehavior="convertToNull" //Java can't convert ''0000-00-00 00:00:00' to TIMESTAMP
            driverClassName = "com.mysql.jdbc.Driver"
            username = "grails"
            password = "server"
            url = "jdbc:mysql://localhost/stdc"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
