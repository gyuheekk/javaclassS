package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyDAO {

	public UserVO getUserMidSearch(@Param("mid") String mid);

	public ArrayList<UserVO> getUserMidList(@Param("mid") String mid);

	public void setSaveCrimeDate(@Param("vo") CrimeVO vo);

	public void setdeleteCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getListCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getYearPoliceCheck(@Param("year") int year, @Param("police") String police, @Param("yearOrder") String yearOrder);

	public CrimeVO getAnalyzeTotal(@Param("year") int year, @Param("police") String police);

	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	public void setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setsetKakaoAddressDelete(@Param("address") String address);

	public void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	public String setQrCodeSearch(@Param("qrCode") String qrCode);

	public QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);

	public int setKakaoAddressDelete(@Param("address") String address);

	public List<TransactionVO> getTransactionList();

	public int setTransactionUserInput(@Param("vo") TransactionVO vo);

	public List<TransactionVO> getTransactionList2();

	public void setTransactionUser1Input(@Param("vo") TransactionVO vo);

	public void setTransactionUser2Input(@Param("vo") TransactionVO vo);

	public void setTransactionUserTotalInput(@Param("vo") TransactionVO vo);
}
