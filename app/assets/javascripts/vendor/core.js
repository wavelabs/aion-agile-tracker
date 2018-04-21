/**
 *
 */
var hexToRgba = function(hex, opacity) {
  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  var rgb = result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16)
  } : null;

  return 'rgba(' + rgb.r + ', ' + rgb.g + ', ' + rgb.b + ', ' + opacity + ')';
};

/**
 *
 */
$(document).ready(function() {
  /** Constant div card */
  const DIV_CARD = 'div.card';

  /** Initialize tooltips */
  $('[data-toggle="tooltip"]').tooltip();

  /** Initialize popovers */
  $('[data-toggle="popover"]').popover({
    html: true
  });

  /** Function for remove card */
  $('[data-toggle="card-remove"]').on('click', function(e) {
    var $card = $(this).closest(DIV_CARD);

    $card.remove();

    e.preventDefault();
    return false;
  });

  /** Function for collapse card */
  $('[data-toggle="card-collapse"]').on('click', function(e) {
    var $card = $(this).closest(DIV_CARD);

    $card.toggleClass('card-collapsed');

    e.preventDefault();
    return false;
  });

  /** Function for collapse iteration */
  $('[data-toggle="iteration-collapse"').on('click', function (e) {
    var $card = $(this).closest(DIV_CARD);
    $card.toggleClass('Iteration--collapsed');
    e.preventDefault();
    return false;
  })

  /** Function for fullscreen card */
  $('[data-toggle="card-fullscreen"]').on('click', function(e) {
    var $card = $(this).closest(DIV_CARD);

    $card.toggleClass('card-fullscreen').removeClass('card-collapsed');

    e.preventDefault();
    return false;
  });

  /**  */
  if ($('[data-sparkline]').length) {
    var generateSparkline = function($elem, data, params) {
      $elem.sparkline(data, {
        type: $elem.attr('data-sparkline-type'),
        height: '100%',
        barColor: params.color,
        lineColor: params.color,
        fillColor: 'transparent',
        spotColor: params.color,
        spotRadius: 0,
        lineWidth: 2,
        highlightColor: hexToRgba(params.color, .6),
        highlightLineColor: '#666',
        defaultPixelsPerValue: 5
      });
    };

    require(['sparkline'], function() {
      $('[data-sparkline]').each(function() {
        var $chart = $(this);

        generateSparkline($chart, JSON.parse($chart.attr('data-sparkline')), {
          color: $chart.attr('data-sparkline-color')
        });
      });
    });
  }

  /**  */
  if ($('.chart-circle').length) {
    require(['circle-progress'], function() {
      $('.chart-circle').each(function() {
        var $this = $(this);

        $this.circleProgress({
          fill: {
            color: tabler.colors[$this.attr('data-color')] || tabler.colors.blue
          },
          size: $this.height(),
          startAngle: -Math.PI / 4 * 2,
          emptyFill: '#F4F4F4',
          lineCap: 'round'
        });
      });
    });
  }

  var $storyLabelList = $('#story_label_list')
  if($storyLabelList.length) {
    $storyLabelList.selectize({
                                delimiter: ',',
                                valueField: 'name',
                                labelField: 'name',
                                searchField: 'name',
                                persist: false,
                                create: function (input) {
                                    return {name: input}
                                },
                                load: function (query, callback) {
                                  var tagsUrl = new URL($storyLabelList.attr('data-url'));
                                  tagsUrl.searchParams.set('name', query);
                                  $.getJSON(tagsUrl.href, function (data) {
                                    return callback(data);
                                  });
                                }
                          });
  }

  var $storyType = $('#story_type');
  if ($storyType.length) {
    $storyType.on('change', function (e) {
      if (this.value != 'feature') {
        $('#story_points').attr('disabled', true)
      } else {
        $('#story_points').attr('disabled', false)
      }
    });
  }

  var $storyOwners = $('#story_owners');
  if($storyOwners.length) {
    $storyOwners.selectize();
  }

  var stories = document.querySelectorAll('.Iteration .Story[draggable=true]');
  var iterations = document.querySelectorAll('.Iteration');
  if(stories) {
    function handleDragStart(e) {
      this.style.opacity = '0.4';
      e.dataTransfer.effectAllowed = 'move';
      e.dataTransfer.setData('text', this.getAttribute('id'));
    }

    function handleDragEnter(e) {
      var isIteration = this.classList.contains('Iteration');

      if (isIteration) { return this.classList.add('Iteration--over'); }
      this.classList.add('Story--over');
    }

    function handleDragOver(e) {
      e.preventDefault();
      e.dataTransfer.dropEffect = 'move';
      return false;
    }

    function handleDragLeave(e) {
      this.classList.remove('Story--over');
      this.classList.remove('Iteration--over');
    }

    function handleDrop(e) {
      e.stopPropagation();
      var isIteration     = this.classList.contains('Iteration');
      var elementId       = e.dataTransfer.getData('text');
      var originalElement = document.getElementById(elementId);

      if(isIteration) {
        this.querySelector('tbody').appendChild(originalElement)
      } else {
        this.insertAdjacentElement('afterend', originalElement);
      }

      return false;
    }

    function handleDragEnd() {
      this.style.opacity = null;
      stories = document.querySelectorAll('.Iteration .Story');
      iterations = document.querySelectorAll('.Iteration');

      [].forEach.call(iterations, function (iteration, index) {
        var stories = iteration.querySelectorAll('.Story');

        iteration.classList.remove('Iteration--over');
        [].forEach.call(stories, function (story, index) {
          story.classList.remove('Story--over');
          data = JSON.parse(story.getAttribute('data-data'));
          data.position = index + 1
          data.iteration_id = iteration.getAttribute('data-id');
          update_position_remotely(data);
        })
      })
    }

    [].forEach.call(stories, function (story) {
      story.addEventListener('dragstart', handleDragStart, false);
      story.addEventListener('dragenter', handleDragEnter, false);
      story.addEventListener('dragover', handleDragOver, false);
      story.addEventListener('dragleave', handleDragLeave, false);
      story.addEventListener('drop', handleDrop, false);
      story.addEventListener('dragend', handleDragEnd, false);
    });

    [].forEach.call(iterations, function (iteration) {
      iteration.addEventListener('dragenter', handleDragEnter, false);
      iteration.addEventListener('dragover', handleDragOver, false);
      iteration.addEventListener('dragleave', handleDragLeave, false);
      iteration.addEventListener('drop', handleDrop, false);
      iteration.addEventListener('dragend', handleDragEnd, false);
    })

    function update_position_remotely(data) {
      $.ajax({
        method: 'PATCH',
        url: '/admin/projects/' + data.project_id + '/stories/' + data.id,
        data: JSON.stringify({ story: data }),
        headers: {
          'X-CSRF-Token': Rails.csrfToken(),
          'Content-Type': 'application/json',
          'Accept':       'application/json'
        }
      })
    }
  }
});
