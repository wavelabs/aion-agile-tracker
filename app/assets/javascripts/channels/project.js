App.cable.subscriptions.create("ProjectsChannel", {
  connected: function () {
    console.log('Connected');
  },
  disconnected: function () {
    console.log('Disconnected');
  },
  received: function (data) {
    var iterationEl = document.querySelector('.Iteration[data-id="' + data.story.iteration_id + '"]');
    if (iterationEl) {
      var tbodyEl = iterationEl.querySelector('tbody');
      tbodyEl.insertAdjacentHTML('beforeend', data.project_row_html);
    } else {
      iterationEl = document.querySelector('.Iteration:last-child');
      iterationEl.insertAdjacentHTML('afterend', data.iteration_card_html);
      iterationEl.querySelector('[data-toggle="iteration-collapse"').addEventListener('click', handleIterationCollapse)
      highlight(document.querySelector('.Iteration:last-child'));
    }

    var storyEl = document.querySelector('#Story-' + data.story.id);
    highlight(storyEl);
    add_drag_listener_to_story_element(storyEl);
  }
});
