-- get path to latest java executable
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- path for .metadata , indexes (ref, gotodef, auto-completion) an project caches (build state)
local workspace_dir = vim.env.XDG_CACHE_HOME .. '/jdtls/workspace/' .. project_name

-- https://projectlombok.org/downloads/lombok.jar > ~/.local/share/java/lombok.jar
local lombok_jar = vim.fs.normalize(vim.env.XDG_DATA_HOME .. "/java/lombok.jar")

function clear_cache()
    local res = vim.fn.delete(workspace_dir, "rf")
    if res == 0 then
        vim.notify("Successfully removed " .. workspace_dir)
    else
        vim.notify("Failed to remove " .. workspace_dir)
    end
end

vim.api.nvim_create_user_command("JDTLSClearCache", clear_cache, {});

---@type vim.lsp.Config
local jdtls = {
    cmd = {
        "jdk27", "jdtls", -- java version to run jdtls with
        "-data", workspace_dir,
        "--jvm-arg=-Djava.import.generatesMetadataFilesAtProjectRoot=false",
        "--jvm-arg=-javaagent:" .. lombok_jar,
    },
    filetypes = { "java" },
    root_markers = { "gradlew", "mvnw", "pom.xml", ".git" },
    init_options = {
        extendedClientCapabilities = {
            classFileContentsSupport = true
        },
        -- must be here, not in the top-level `settings`: jdtls imports projects
        -- during initialize, before workspace/didChangeConfiguration arrives
        settings = {
            java = {
                -- must be a boolean: jdtls ignores vscode-java's "auto"/"on"/"off" strings
                jdt = { ls = { androidSupport = { enabled = true } } },
                import = {
                    gradle = {
                        -- androidSupport needs the `eclipse` Gradle plugin on Android modules
                        arguments = { "--init-script", vim.fn.stdpath("config") .. "/jdtls/eclipse-init.gradle" },
                    },
                },
            },
        },
    },
}

vim.lsp.config("jdtls", jdtls)
vim.lsp.enable("jdtls")
