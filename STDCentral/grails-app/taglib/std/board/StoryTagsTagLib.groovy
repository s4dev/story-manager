package std.board

class StoryTagsTagLib {
    static namespace = "st"

    def displayAssociation = { attrs, body ->
        def field = attrs.fieldname
        def list = attrs.list
        def errorClass = attrs.errorClass
        def width = attrs.width ?: "45%"
        def truncate = attrs.truncateSize ? attrs.truncateSize.toInteger() ?: 0 : 55


        out << """
        <div class='floatLeft fieldcontain ${errorClass}' style='width:${width};'>
            <label for='${field}'>
        """

        out << g.message(code:"story.${field}.label", default:"${field.capitaliseAllWords()}")

        out << """
            </label>
            <br/>
            <div class='fieldlist'>
                <ul class='one-to-many'>
        """
        list.each { l ->
            if (truncate)
                out << "<li>${d.truncate([size: truncate, body: l.toString()])}</li>"
            else
                out << "<li>${l.encodeAsHTML()}</li>"
        }
        out << """
                </ul>
            </div>
        </div>
        """
    }

    def editAssociation = { attrs, body ->
        def field = attrs.fieldname ?: ''
        def list = attrs.list ?: []
        def assocController = attrs.controller ?: field[0 .. field.size()-2]
        def storyId = attrs.parentId
        def width = attrs.width ?: "45%"
        def truncate = attrs.truncateSize ? attrs.truncateSize.toInteger() ?: 0 : 55


        out << """
        <div class='floatLeft fieldcontain' style='width:${width};'>
            <span id='${field}-label' class='property-label'>
        """

        out << g.message(code:"story.${field}.label", default:"${field.capitaliseAllWords()}")

        out << """
            </span>
            <br/>
            <div class='fieldlist'>
                <ul class='one-to-many'>
        """
        list.each { l ->
            def txt = l.encodeAsHTML()
            if (truncate)
                txt = d.truncate([size: truncate, body: l.toString()])

            out << "<li aria-labelledby='${field}-label'>"
            out << g.link([controller:"${assocController}", action:"edit", id:"${l.id}"], "${txt}")
            out << "</li>"
        }
        out << "<ul><li aria-labelledby='${field}-label'>"

        //TODO: figure out why the hell this is needed - g.link will not display params with complex label
        def linkAttrs = [:]
        linkAttrs.controller = "${assocController}"
        linkAttrs.action = "create"
        linkAttrs['story.id'] = storyId
        linkAttrs.params = [:]
        linkAttrs.params['story.id'] = storyId

        def linkBody = message(code: 'default.add.label', args: [message(code: "${assocController}.label", default: "${assocController.capitaliseAllWords()}")])

        out << g.link(linkAttrs, linkBody)
        out << """
                        </li>
                    </ul>
                </ul>
            </div>
        </div>
        """
    }
}
