module WaitForAjax
  def wait_for_ajax
    Capybara.default_max_wait_time = maximum
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
    Capybara.default_max_wait_time = minimum
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def minimum
    minimum = 7
  end

  def maximum
    maximum = 120
  end
end
