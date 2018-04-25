function handleUpdateStory(data) {
  var $story = document.querySelector('#Story-'+data.story.id);
  $story.outerHTML = data.project_row_html;
  $story = document.querySelector('#Story-'+data.story.id);
  highlight($story);
}

function handleCreateStory(data) {
  var iterationEl = document.querySelector('.Iteration[data-id="' + data.story.iteration_id + '"]');
  if (iterationEl) {
    var tbodyEl = iterationEl.querySelector('tbody');
    tbodyEl.insertAdjacentHTML('beforeend', data.project_row_html);
  } else {
    iterationEl = document.querySelector('.Iteration:last-child');
    iterationEl.insertAdjacentHTML('afterend', data.iteration_card_html);
    iterationEl.querySelector('[data-toggle="iteration-collapse"').addEventListener('click', handleIterationCollapse)
  }

  $story = document.querySelector('#Story-'+data.story.id);
  highlight($story);
}

function handleUpdatePositions(data) {
  [].forEach.call(data.project.iterations_attributes, function (iteration) {
    var $iteration = document.querySelector('#Iteration-'+iteration.id);
    var $tbody     = $iteration.querySelector('tbody');
    [].forEach.call(iteration.stories_attributes, function (story) {
      var $story = document.querySelector('#Story-'+story.id);
      $tbody.appendChild($story)
    })
  });
}

App.cable.subscriptions.create("ProjectsChannel", {
  connected: function () {
    console.log('Connected');
  },
  disconnected: function () {
    console.log('Disconnected');
  },
  received: function (data) {
    switch (data.action) {
      case 'POSITIONS_UPDATED':
        handleUpdatePositions(data);
        break;
      case 'STORY_CREATED':
        handleCreateStory(data);
        break;
      case 'STORY_UPDATED':
        handleUpdateStory(data);
        break;
    }

    // var storyEl = document.querySelector('#Story-' + data.story.id);
    // add_drag_listener_to_story_element(storyEl);
    // if (!storyEl.parentNode.classList.contains('Iteration--collapsed')) {
    //   highlight(storyEl);
    // } else {
    //   highlight(storyEl.parentNode)
    // }
  }
});
