
package dao;

import dao.mydao.MyDAO;
import java.util.ArrayList;
import java.util.List;
import model.Account;

public class AccountDAO extends MyDAO{
    public List<Account> getAllAccount() {
        List<Account> acounts = new ArrayList<>();
        xSql = "select * from Account";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while(rs.next()){
                int accountID = rs.getInt(1);
                String email = rs.getString(2);
                String passWord = rs.getString(3);
                int status = rs.getInt(4);
                int role = rs.getInt(5);
                acounts.add(new Account(accountID,email,passWord,status,role));
            }          
        } catch (Exception e) {
            System.out.println(e);
        }

        return acounts;
    }
    
}
