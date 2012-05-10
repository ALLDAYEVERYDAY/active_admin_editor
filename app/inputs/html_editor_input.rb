class HtmlEditorInput < Formtastic::Inputs::TextInput
  def toolbar
    <<-HTML
    <div id="#{input_html_options[:id]}-toolbar" class="active_admin_editor_toolbar">
      
      <a data-wysihtml5-action="change_view"><span>Source</span></a>
      <a data-wysihtml5-command="bold" title="Bold"><span>Bold</span></a>
      <a data-wysihtml5-command="italic" title="Italic"><span>Italic</span></a>
      <a data-wysihtml5-command="createLink" title="Link"><span>Link</span></a>
      <a data-wysihtml5-command="insertImage" title="Image"><span>Image</span></a>
      <a data-wysihtml5-command="insertUnorderedList" title="Unordered list"><span>Bulleted List</span></a>
      <a data-wysihtml5-command="insertOrderedList" title="Ordered list"><span>Numbered List</span></a>
      <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h1">h1</a>
      <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h2">h2</a>
      <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h3">h3</a>
      #{%Q{<a class="button quicksave" href="#">Save</a>} if input_html_options[:quicksave]}

      <div data-wysihtml5-dialog="createLink" style="display: none">
        <label>
          Link:
          <input type="text" data-wysihtml5-dialog-field="href" value="http://">
        </label>
        <div class="action-group">
          <a data-wysihtml5-dialog-action="save" class="button">OK</a>
          <a data-wysihtml5-dialog-action="cancel">Cancel</a>
        </div>
      </div>
      
      <div data-wysihtml5-dialog="insertImage" style="display: none">
        <div class="tabs">
          <ul>
            <li><a href="##{input_html_options[:id]}-simple-insert">Simple</a></li>
            <li><a href="##{input_html_options[:id]}-advanced-insert" data-load-assets="true">Library</a></li>
            <li><a href="##{input_html_options[:id]}-upload" data-load-assets-new="true">Upload</a></li>
          </ul>
          <div id="#{input_html_options[:id]}-simple-insert" class="simple_insert">
            <label>
              Image:
              <input type="text" data-wysihtml5-dialog-field="src" value="http://">
            </label>
          </div>
          <div id="#{input_html_options[:id]}-advanced-insert" class="advanced_insert">
          </div>
          <div id="#{input_html_options[:id]}-upload" class="upload_insert">
          </div>
        </div>
        <label>
          Align:
          <select data-wysihtml5-dialog-field="className">
            <option value="">default</option>
            <option value="wysiwyg-float-left">left</option>
            <option value="wysiwyg-float-right">right</option>
          </select>
        </label>
        <div class="action-group">
          <a data-wysihtml5-dialog-action="save" class="button">OK</a>
          <a data-wysihtml5-dialog-action="cancel">Cancel</a>
        </div>
      </div>
      
    </div>
    HTML
  end

  def input_html_options
    {
      quicksave: false
    }.merge(super)
  end

  def to_html
    html = '<div class="active_admin_editor">'
    html << toolbar.html_safe
    html << builder.text_area(method, input_html_options)
    html << '</div>'
    html << '<div style="clear: both"></div>'
    input_wrapping do
      label_html << html.html_safe
    end
  end
end
