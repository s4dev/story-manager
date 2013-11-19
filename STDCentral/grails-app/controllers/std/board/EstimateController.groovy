package std.board

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class EstimateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [estimateInstanceList: Estimate.list(params), estimateInstanceTotal: Estimate.count()]
    }

    def ajaxListByStory() {
        def list = Estimate.createCriteria().list() {
            story {
                eq("id", params?.storyId)
            }
        }

        render list*.toString() as JSON
    }

    def create() {
        [estimateInstance: new Estimate(params)]
    }

    def ajaxCreate() {
        render(template: 'estimateform', model: [estimateInstance: new Estimate(params), i:params.i])
    }

    def save() {
        def estimateInstance = new Estimate(params)
        if (!estimateInstance.save(flush: true)) {
            render(view: "create", model: [estimateInstance: estimateInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'estimate.label', default: 'Estimate'), estimateInstance.id])
		if (estimateInstance.story)
            redirect(controller: "story", action: "show", id: estimateInstance.story?.id)
        else
            redirect(action: "show", id: estimateInstance.id)
    }

    def show() {
        def estimateInstance = Estimate.get(params.id)
        if (!estimateInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            redirect(action: "list")
            return
        }

        [estimateInstance: estimateInstance]
    }

    def edit() {
        def estimateInstance = Estimate.get(params.id)
        if (!estimateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            redirect(action: "list")
            return
        }

        [estimateInstance: estimateInstance]
    }

    def update() {
        def estimateInstance = Estimate.get(params.id)
        if (!estimateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (estimateInstance.version > version) {
                estimateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'estimate.label', default: 'Estimate')] as Object[],
                          "Another user has updated this Estimate while you were editing")
                render(view: "edit", model: [estimateInstance: estimateInstance])
                return
            }
        }

        estimateInstance.properties = params

        if (!estimateInstance.save(flush: true)) {
            render(view: "edit", model: [estimateInstance: estimateInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'estimate.label', default: 'Estimate'), estimateInstance.id])
		if (estimateInstance.story)
            redirect(controller: "story", action: "show", id: estimateInstance.story?.id)
        else
            redirect(action: "show", id: estimateInstance.id)
    }

    def delete() {
        def estimateInstance = Estimate.get(params.id)
        def storyId = estimateInstance?.story?.id
        if (!estimateInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            redirect(action: "list")
            return
        }

        try {
            estimateInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            if (storyId)
                redirect(controller: "story", action: "show", id: storyId)
            else
                redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'estimate.label', default: 'Estimate'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
