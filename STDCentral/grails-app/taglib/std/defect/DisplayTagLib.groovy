package std.defect

class DisplayTagLib {

	static namespace = "d"


	/**
     * This will truncate the item and if it extends past the default length we will truncate and show
     * the rest in a tooltip.
     * Default Length = 30
     * decorate = true by default. False if we dont want to display the tool tip stuff
     * <d:truncate size="30" decorate="false"></d:truncate>
	 */
	def truncate = { attrs, body ->
		def size = attrs.size?.toInteger() ?: 29
	  	def decorate = attrs.decorate == null ? true : attrs.decorate?.toBoolean()

		// Remove HTML Fromatting
		def value = body()
		if (!value) value = attrs.body

		if (! value) return

		def strippedValue = value?.replaceAll("<(.|\n)*?>", '')?.trim();
		if (strippedValue?.length() > size) {              
		    if (decorate)
		        // escape single quotes in tooltip with &#39;
		        out << """<span class='tooltip' 
		                    title='${strippedValue?.replace("'",'&#39;')}'>
		                ${strippedValue?.substring(0,size)?.encodeAsHTML()}...
		            </span>"""
		    else 
		        out << "${strippedValue?.substring(0,size)?.encodeAsHTML()}..."
		}
		else {
			out << value.encodeAsHTML()
		}
    }

}
