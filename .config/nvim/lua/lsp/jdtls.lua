-- get path to latest java executable
local function get_latest_java()
    local jvms = vim.fn.glob("/usr/lib/jvm/java-*", true, true)
    local latest_path = "java"
    local latest_version = -1
    for _, path in ipairs(jvms) do
        local version = path:match("java%-(%d+)") -- extract major version number
        if not version then goto fin end
        version = tonumber(version)
        if not version or version < latest_version then goto fin end
        latest_version = version
        latest_path = path .. "/bin/java"
        ::fin::
    end
    return latest_path
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- path for .metadata , indexes (ref, gotodef, auto-completion) an project caches (build state)
local workspace_dir = os.getenv('XDG_CACHE_HOME') .. '/jdtls/workspace/' .. project_name

vim.lsp.config("jdtls", {
    cmd = { "jdtls", "--java-executable", get_latest_java(), "-data", workspace_dir },
    filetypes = { "java" },
    root_markers = { "gradlew", "mvnw", "pom.xml", ".git" },
    init_options = {
        extendedClientCapabilities = {
            classFileContentsSupport = true
        }
    },
})

vim.lsp.enable("jdtls")
