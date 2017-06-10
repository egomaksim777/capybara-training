module Helpers
  def wait_for_ajax
    Timeout.timeout(max_timeout) { loop until finished_all_ajax_requests? }
  end

  def finished_all_ajax_requests?
    evaluate_script('jQuery.active').zero?
  end

  def max_timeout
    60
  end

  def min_timeout
    7
  end

  def wait_for_ajax_updated
    Timeout.timeout(max_timeout) do
      diff = 1

      while diff != 0
        diff1 = evaluate_script('jQuery.active')
        sleep 1
        diff2 = evaluate_script('jQuery.active')
        diff = diff1 - diff2
      end
    end
  end
end
