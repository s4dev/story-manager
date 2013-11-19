package std.board



import org.junit.*
import grails.test.mixin.*

@TestFor(ConfirmationController)
@Mock(Confirmation)
class ConfirmationControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/confirmation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.confirmationInstanceList.size() == 0
        assert model.confirmationInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.confirmationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.confirmationInstance != null
        assert view == '/confirmation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/confirmation/show/1'
        assert controller.flash.message != null
        assert Confirmation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/confirmation/list'


        populateValidParams(params)
        def confirmation = new Confirmation(params)

        assert confirmation.save() != null

        params.id = confirmation.id

        def model = controller.show()

        assert model.confirmationInstance == confirmation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/confirmation/list'


        populateValidParams(params)
        def confirmation = new Confirmation(params)

        assert confirmation.save() != null

        params.id = confirmation.id

        def model = controller.edit()

        assert model.confirmationInstance == confirmation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/confirmation/list'

        response.reset()


        populateValidParams(params)
        def confirmation = new Confirmation(params)

        assert confirmation.save() != null

        // test invalid parameters in update
        params.id = confirmation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/confirmation/edit"
        assert model.confirmationInstance != null

        confirmation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/confirmation/show/$confirmation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        confirmation.clearErrors()

        populateValidParams(params)
        params.id = confirmation.id
        params.version = -1
        controller.update()

        assert view == "/confirmation/edit"
        assert model.confirmationInstance != null
        assert model.confirmationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/confirmation/list'

        response.reset()

        populateValidParams(params)
        def confirmation = new Confirmation(params)

        assert confirmation.save() != null
        assert Confirmation.count() == 1

        params.id = confirmation.id

        controller.delete()

        assert Confirmation.count() == 0
        assert Confirmation.get(confirmation.id) == null
        assert response.redirectedUrl == '/confirmation/list'
    }
}
