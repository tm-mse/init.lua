return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},

		config = function ()
			local dap, dapui = require('dap'),require('dapui')
			dapui.setup()
			require('dap-go').setup()

			-- makes Break point look prettier
			vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
			vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

			-- initialize dap-ui when starting dap
			dap.listeners.before.attach.dapui_config = function()
  			dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
			  dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
			  dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
			  dapui.close()
			end

			dap.set_log_level('DEBUG')

		end,

		keys = {
    	{ "<leader>b", function() require("dap").toggle_breakpoint() end, mode = "n"},
    	{ "<leader>B", function() require("dap").set_breakpoint() end, mode = "n"},
    	{ "<leader>dc", function() require("dap").continue() end, mode = "n"},
    	{ "<leader>di", function() require("dap").step_into() end, mode = "n"},
    	{ "<leader>dO", function() require("dap").step_over() end, mode = "n"},
    	{ "<leader>do", function() require("dap").step_out() end, mode = "n"},
    	{ "<leader>dq", function() require("dapui").close() end, mode = "n"},
    	{ "<leader>du", function() require("dapui").open() end, mode = "n"},
			-- run test in golang
    	{ "<leader>gt", function() require("dap-go").debug_test() end, mode = "n"},
    	{ "<leader>glt", function() require("dap-go").debug_last_test() end, mode = "n"},
		},
  },
}
