module WaitForAjax
  def wait_for_ajax
    Capybara.default_max_wait_time = 120
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
    Capybara.default_max_wait_time = 14
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
