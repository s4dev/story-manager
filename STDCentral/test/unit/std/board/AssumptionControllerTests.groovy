package std.board



import org.junit.*
import grails.test.mixin.*

@TestFor(AssumptionController)
@Mock(Assumption)
class AssumptionControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/assumption/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.assumptionInstanceList.size() == 0
        assert model.assumptionInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.assumptionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.assumptionInstance != null
        assert view == '/assumption/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/assumption/show/1'
        assert controller.flash.message != null
        assert Assumption.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/assumption/list'


        populateValidParams(params)
        def assumption = new Assumption(params)

        assert assumption.save() != null

        params.id = assumption.id

        def model = controller.show()

        assert model.assumptionInstance == assumption
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/assumption/list'


        populateValidParams(params)
        def assumption = new Assumption(params)

        assert assumption.save() != null

        params.id = assumption.id

        def model = controller.edit()

        assert model.assumptionInstance == assumption
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/assumption/list'

        response.reset()


        populateValidParams(params)
        def assumption = new Assumption(params)

        assert assumption.save() != null

        // test invalid parameters in update
        params.id = assumption.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/assumption/edit"
        assert model.assumptionInstance != null

        assumption.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/assumption/show/$assumption.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        assumption.clearErrors()

        populateValidParams(params)
        params.id = assumption.id
        params.version = -1
        controller.update()

        assert view == "/assumption/edit"
        assert model.assumptionInstance != null
        assert model.assumptionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/assumption/list'

        response.reset()

        populateValidParams(params)
        def assumption = new Assumption(params)

        assert assumption.save() != null
        assert Assumption.count() == 1

        params.id = assumption.id

        controller.delete()

        assert Assumption.count() == 0
        assert Assumption.get(assumption.id) == null
        assert response.redirectedUrl == '/assumption/list'
    }
}
