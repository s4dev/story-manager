import std.board.*
import std.defect.*
import std.security.*
import org.apache.commons.lang.StringUtils

class BootStrap {

    def init = { servletContext ->

        //add StringUtils methods directly to String class
        String.metaClass.mixin StringUtils

        if ( ! User.count() ) initUsers()
        if ( ! Status.count() ) initStatuses()
        if ( ! Severity.count() ) initSeverities()
        if ( ! Env.count() ) initEnvironments()
        if ( ! FunctionalArea.count() ) initFunctionalAreas()
        if ( ! BoardState.count() ) initBoardStates()
        if ( ! Person.count() ) initSecurityPersons()

    }

    def destroy = {
    }

    def initSecurityPersons() {
        def adminRole = new Role(authority: 'ROLE_STDC').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new Person(username: 'stdc', enabled: true, password: 'valtrex')
        testUser.save(flush: true)

        def assign = PersonRole.create testUser, adminRole, true
        assign.save()

        assert Person.count() == 1
        assert Role.count() == 2
        assert PersonRole.count() == 1
    }

    def initUsers() {
        new User( firstName:'David', lastName:'Kuster', email:'kusterd1@scottsdaleins.com' ).save()
        new User( firstName:'Ali', lastName:'Tapal', email:'tapala@scottsdaleins.com' ).save()
        new User( firstName:'Stephen', lastName:'Cihak', email:'cihaks@scottsdaleins.com' ).save()
        //new User( firstName:'Peter', lastName:'Kipping', email:'kippinp1@scottsdaleins.com' ).save()
        new User( firstName:'Mark', lastName:'Peterson', email:'petersm9@scottsdaleins.com' ).save()
        new User( firstName:'Alan', lastName:'Sparago', email:'sparaga1@scottsdaleins.com' ).save()
        new User( firstName:'Waqas', lastName:'Hassan', email:'hassanw@scottsdaleins.com' ).save()
        new User( firstName:'Joseph', lastName:'Nusairat', email:'nusairj1@scottsdaleins.com' ).save()
        //new User( firstName:'Ervin', lastName:'Makuri', email:'na@scottsdaleins.com' ).save()
        new User( firstName:'Nick', lastName:'Kusama', email:'kusamas@scottsdaleins.com' ).save()
        new User( firstName:'Yaman', lastName:'Rangineni', email:'ranginy1@scottsdaleins.com' ).save()
        new User( firstName:'QA/DEV', lastName:'QA', email:'qa@scottsdaleins.com' ).save()
        new User( firstName:'SA', lastName:'SA', email:'sa@scottsdaleins.com' ).save()
    }


    def initStatuses() {
        ['Open', 'Fixed But Not Checked In','Ready For Test', 'Closed', 'Closed by Req. Update'].each { status ->
            new Status( name:status ).save()
        }
    }


    def initSeverities() {
        ['Critical', 'High', 'Medium', 'Low'].each { severity ->
            new Severity( name:severity ).save()
        }
    }


    def initEnvironments() {
        // envs
        ['Dev', 'QA', 'PT', 'FT', 'Prod'].each { env ->
            new Env( name:env ).save()
        }
    }

    def initFunctionalAreas() {/*
        new FunctionalArea(name: 'Guide Administration', sortOrder: 1).save()
        new FunctionalArea(name: 'Publication', sortOrder: 2).save()
        new FunctionalArea(name: 'Guide Viewer', sortOrder: 3).save()
        new FunctionalArea(name: 'Program Administration', sortOrder: 4).save()
        new FunctionalArea(name: 'Program Web Service', sortOrder: 5).save()
        new FunctionalArea(name: 'Research', sortOrder: 6).save()
    */}

    def initBoardStates() {/*
        new BoardState(name: 'Backlog', sortOrder: 1).save()
        new BoardState(name: 'Development', sortOrder: 2).save()
        new BoardState(name: 'Testing', sortOrder: 3).save()
        new BoardState(name: 'Complete', sortOrder: 4).save()
    */}

}
