# Rails creates this event, when the link_to(remote: true)
# successfully executes
# syntax $(document).on 'ajax:success', tag.class or tag#id
$(document).on 'ajax:success', 'a.like', (status, data, xhr)->
# the `data` parameter is the decoded JSON object

# set document: class="likes-count" with data-id = data.id a new text
# returned on ajax event
  $(".likes-count[data-id=#{data.id}]").text data.count

  # toggle links -> within data- prefix in tag a class"like"
  $("a.like[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr 'href'
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return


  return





