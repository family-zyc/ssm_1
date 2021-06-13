package cn.zyc.controller;

import cn.zyc.pojo.Employee;
import cn.zyc.pojo.Msg;
import cn.zyc.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zyc
 * @date 2021/6/8
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据（分页查询）
     * 使用servlet作法
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pn" ,defaultValue="1") Integer pn, Model model){
        //使用pageHelper进行分页
        PageHelper.startPage(pn,5); //该后面紧跟的查询就是分页查询
        List<Employee> list = employeeService.getAll();
        /*
            使用Page Info包装查询后的结果
            第二参数：连续显示的页数
         */
        PageInfo pageInfo = new PageInfo(list,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }

    /**
     * 查询员工数据（分页查询）
     * 使用ajax返回json串
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn" ,defaultValue="1") Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(list,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 添加员工
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp", method= RequestMethod.POST)
    @ResponseBody
    public Msg addEmp(@Valid Employee employee, BindingResult bindingResult){
        Map<String,Object> map = new HashMap<>();
        if(bindingResult.hasErrors()){  //if check has errors
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError error : fieldErrors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.addEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkUserName")
    @ResponseBody
    public Msg checkUserName(@RequestParam("empName") String empName){
        //校验用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{2,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2~5位中文或2~16位英文和数字的组合~");
        }

        boolean flag = employeeService.checkUserName(empName);
        if(flag){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * find employee by id
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}" ,method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    /**
     * update employee information
     * @param emp
     * @return
     */
    @RequestMapping(value = "/emp/{empId}" ,method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee emp){
        employeeService.updateEmp(emp);
        return Msg.success();
    }

    /**
     * delete employees by id
     * format:1-2-3
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{id}" ,method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("id") String ids){
        if(ids.contains("-")){  //delete multi employees
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String str : str_ids){
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }else{  //delete single employee
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }

}
