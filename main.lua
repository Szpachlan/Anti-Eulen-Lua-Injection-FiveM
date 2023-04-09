local res_find_index = GetResourceByFindIndex
local num_resources = GetNumResources
local resource_state = GetResourceState
CreateThread(function()
    Wait(2000)
    local resourceList = {}
    for i = 0, num_resources(), 1 do
        local resource_name = res_find_index(i)
        if resource_name and resource_state(resource_name) == "started" then
            resourceList[resource_name] = true
        end
    end
    for i = 1,10 do
        Wait(0)
        CreateThread(function()
            while true do
                Wait(0)
                for i = 0, num_resources()-1, 1 do
                    local res = res_find_index(i)
                    if resourceList[res] == nil then
                        if resource_state(res) == "uninitialized" then
                            print("new resource found: " .. res)
                            break
                        end
                    end
                end
            end
        end)
    end
end)
