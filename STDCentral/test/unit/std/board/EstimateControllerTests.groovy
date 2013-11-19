package std.board



import org.junit.*
import grails.test.mixin.*

@TestFor(EstimateController)
@Mock(Estimate)
class EstimateControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/estimate/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.estimateInstanceList.size() == 0
        assert model.estimateInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.estimateInstance != null
    }

    void testSave() {
        controller.save()

        assert model.estimateInstance != null
        assert view == '/estimate/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/estimate/show/1'
        assert controller.flash.message != null
        assert Estimate.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/estimate/list'


        populateValidParams(params)
        def estimate = new Estimate(params)

        assert estimate.save() != null

        params.id = estimate.id

        def model = controller.show()

        assert model.estimateInstance == estimate
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/estimate/list'


        populateValidParams(params)
        def estimate = new Estimate(params)

        assert estimate.save() != null

        params.id = estimate.id

        def model = controller.edit()

        assert model.estimateInstance == estimate
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/estimate/list'

        response.reset()


        populateValidParams(params)
        def estimate = new Estimate(params)

        assert estimate.save() != null

        // test invalid parameters in update
        params.id = estimate.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/estimate/edit"
        assert model.estimateInstance != null

        estimate.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/estimate/show/$estimate.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        estimate.clearErrors()

        populateValidParams(params)
        params.id = estimate.id
        params.version = -1
        controller.update()

        assert view == "/estimate/edit"
        assert model.estimateInstance != null
        assert model.estimateInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/estimate/list'

        response.reset()

        populateValidParams(params)
        def estimate = new Estimate(params)

        assert estimate.save() != null
        assert Estimate.count() == 1

        params.id = estimate.id

        controller.delete()

        assert Estimate.count() == 0
        assert Estimate.get(estimate.id) == null
        assert response.redirectedUrl == '/estimate/list'
    }
}
