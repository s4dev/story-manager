package std.board

class CustomTagLib {
    static namespace = "i"

    def avatar = { attrs, body ->
        def username = attrs?.username ?: ''
        def filename = attrs?.filename ?: ''
        def alt = username ? "(${username})" : ''
        if (filename)
            out << g.img(dir:'images/avatars', class: 'avatar',
                    file: "${filename}", title: "${username}", alt: alt)
    }

    def datepicker = { attrs, body ->
        def name = attrs?.name ?: 'datepicker'
        if (!attrs?.name)
            attrs['name'] = name
        def id = attrs?.id ?: name
        def date = attrs?.value
        if (date && !(date instanceof Date))
            date = Date.parseDate('MM/dd/yyyy', date)

        attrs.value = date ? date.format('MM/dd/yyyy') : null

        out << g.textField(attrs)
        out << g.hiddenField(name: "${name}_month", value: date?.format('MM'))
        out << g.hiddenField(name: "${name}_day", value: date?.format('dd'))
        out << g.hiddenField(name: "${name}_year", value: date?.format('yyyy'))
        out << """
            <script>
                \$(function(){
                    \$(\"#${id}\").datepicker({
                        onClose: function(dateText, inst) {
                            if (dateText) {
                                \$(\"#${name}_month\").attr(\"value\",new Date(dateText).getMonth()+1);
                                \$(\"#${name}_day\").attr(\"value\",new Date(dateText).getDate());
                                \$(\"#${name}_year\").attr(\"value\",new Date(dateText).getFullYear());
                            } else {
                                \$(\"#${name}_month\").attr(\"value\",'');
                                \$(\"#${name}_day\").attr(\"value\",'');
                                \$(\"#${name}_year\").attr(\"value\",'');
                            }
                        }
                    });
                });
            </script>
        """
    }
}