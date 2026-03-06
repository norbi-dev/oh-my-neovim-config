return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    -- Only load when DAP itself is loaded
    event = "User DapStarted",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      -- Auto-open/close dapui when debugging starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
