function MenuItemInput:init(data_node, parameters)
  MenuItemInput.super.init(self, data_node, parameters)

  self._esc_released_callback = 0
  self._enter_callback = 0
  self._typing_callback = 0
  self._type = MenuItemInput.TYPE
  self._input_text = ""
  self._input_limit = 255
  self._empty_gui_input_limit = self._parameters.empty_gui_input_limit or self._input_limit / 2
end
