package std.defect



import org.junit.*
import grails.test.mixin.*

@TestFor(DefectController)
@Mock(Defect)
class DefectControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/defect/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.defectInstanceList.size() == 0
        assert model.defectInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.defectInstance != null
    }

    void testSave() {
        controller.save()

        assert model.defectInstance != null
        assert view == '/defect/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/defect/show/1'
        assert controller.flash.message != null
        assert Defect.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/defect/list'

        populateValidParams(params)
        def defect = new Defect(params)

        assert defect.save() != null

        params.id = defect.id

        def model = controller.show()

        assert model.defectInstance == defect
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/defect/list'

        populateValidParams(params)
        def defect = new Defect(params)

        assert defect.save() != null

        params.id = defect.id

        def model = controller.edit()

        assert model.defectInstance == defect
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/defect/list'

        response.reset()

        populateValidParams(params)
        def defect = new Defect(params)

        assert defect.save() != null

        // test invalid parameters in update
        params.id = defect.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/defect/edit"
        assert model.defectInstance != null

        defect.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/defect/show/$defect.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        defect.clearErrors()

        populateValidParams(params)
        params.id = defect.id
        params.version = -1
        controller.update()

        assert view == "/defect/edit"
        assert model.defectInstance != null
        assert model.defectInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/defect/list'

        response.reset()

        populateValidParams(params)
        def defect = new Defect(params)

        assert defect.save() != null
        assert Defect.count() == 1

        params.id = defect.id

        controller.delete()

        assert Defect.count() == 0
        assert Defect.get(defect.id) == null
        assert response.redirectedUrl == '/defect/list'
    }
}
