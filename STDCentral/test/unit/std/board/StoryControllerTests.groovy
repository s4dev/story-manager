package std.board



import org.junit.*
import grails.test.mixin.*

@TestFor(StoryController)
@Mock(Story)
class StoryControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/story/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.storyInstanceList.size() == 0
        assert model.storyInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.storyInstance != null
    }

    void testSave() {
        controller.save()

        assert model.storyInstance != null
        assert view == '/story/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/story/show/1'
        assert controller.flash.message != null
        assert Story.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/story/list'


        populateValidParams(params)
        def story = new Story(params)

        assert story.save() != null

        params.id = story.id

        def model = controller.show()

        assert model.storyInstance == story
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/story/list'


        populateValidParams(params)
        def story = new Story(params)

        assert story.save() != null

        params.id = story.id

        def model = controller.edit()

        assert model.storyInstance == story
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/story/list'

        response.reset()


        populateValidParams(params)
        def story = new Story(params)

        assert story.save() != null

        // test invalid parameters in update
        params.id = story.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/story/edit"
        assert model.storyInstance != null

        story.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/story/show/$story.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        story.clearErrors()

        populateValidParams(params)
        params.id = story.id
        params.version = -1
        controller.update()

        assert view == "/story/edit"
        assert model.storyInstance != null
        assert model.storyInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/story/list'

        response.reset()

        populateValidParams(params)
        def story = new Story(params)

        assert story.save() != null
        assert Story.count() == 1

        params.id = story.id

        controller.delete()

        assert Story.count() == 0
        assert Story.get(story.id) == null
        assert response.redirectedUrl == '/story/list'
    }
}
