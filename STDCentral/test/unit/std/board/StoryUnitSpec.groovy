package std.board


import spock.lang.*
import grails.test.mixin.*
import org.junit.*


/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Story)
class StoryUnitSpec extends Specification {

    def setupSpec() {
        mockDomain(FunctionalArea, [
            [name: "Area1", sortOrder: 1],
            [name: "Area2", sortOrder: 2]
        ])
        mockDomain(BoardState, [
            [name: "Backlog"],
            [name: "Requirements"],
            [name: "Development"],
            [name: "Testing"],
            [name: "Complete"]
        ])
    }

    def "test nullable story constraints"() {
        setup:
            mockForConstraintsTests(Story)
            def badStory = new Story()

        expect:
            assert !badStory.validate()
            assert "nullable" == badStory.errors["priority"]
            assert "nullable" == badStory.errors["statement"]
            assert "nullable" == badStory.errors["functionalArea"]
            assert "nullable" == badStory.errors["state"]
            assert "nullable" == badStory.errors["topic"]
            assert "nullable" == badStory.errors["phase"]
            assert "nullable" == badStory.errors["build"]

    }

    def "test story constraints"() {
        given:
            def existingStory = new Story(
                statement: "New Story",
                topic: "New Topic",
                phase: "1",
                build: "0",
                priority: Priority.TBD,
                functionalArea: FunctionalArea.get(1 as Long),
                state: BoardState.get(1 as Long)
            )
            mockForConstraintsTests(Story, [existingStory])
        
        when:
            def badStory = new Story(statement: "New Story")

        then:
            assert !badStory.validate()
            assert "nullable" == badStory.errors["statement"]

    }
}
